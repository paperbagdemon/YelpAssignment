//
//  HomeViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Combine

enum BusinessSortType: String, CaseIterable, Identifiable {
    case distance
    case rating
    var id: String { rawValue }
    init?(id: Int) {
        switch id {
        case 1: self = .distance
        case 2: self = .rating
        default: return nil
        }
    }

}

final class BusinessesHomeViewModel: ObservableObject {
    private var apiClient: APIClient!
    private var locationService = LocationService.defaultService
    private var bag = Set<AnyCancellable>()
    @Published private(set) var businesses: (value: [Business]?, error: Error?)
    @Published private(set) var deals: (value: [Business]?, error: Error?)
    @Published private(set) var businessesCancellable: AnyCancellable?

    var sortType = BusinessSortType.distance {
        didSet {
           sortBusinesses()
        }
    }
    var isSortedAscending = true {
        didSet {
            sortBusinesses()
        }
    }

    // MARK: Lifecycle
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    convenience init(apiClient: APIClient, businesses: [Business]? = nil) {
        self.init(apiClient: apiClient)
        self.businesses.value = businesses
    }

    // MARK: Webservices
    func searchBusinesses(keyword: String? = nil, location: String? = nil, categories: [String]? = nil, attributes: [String]? = nil) -> Future<[Business]?, Error>? {

        guard let keyword = keyword?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
            //do nothing
            return nil
        }

        return Future<[Business]?, Error> { promise in
            let service = SearchBusinessAPIService.init(client: self.apiClient)
            if let locationValue = location?.trimmingCharacters(in: .whitespacesAndNewlines), !locationValue.isEmpty {
                service.location = locationValue
            } else if let coordinates = self.locationService.coordinates {
                service.latitude = coordinates.latitude
                service.longitude = coordinates.longitude
            } else {
                let error = LocationError("Location is not provided, please enter a location in search bar or enable location services.")
                self.businesses = (nil, error)
                promise(.failure(error))
                return
            }
            service.term = keyword
            service.categories = categories
            service.radius = 40000
            service.attributes = attributes
            self.businessesCancellable = service.request()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.businesses = (nil, error)
                    promise(.failure(error))
                case .finished: ()
                }
                self.businessesCancellable = nil
            }, receiveValue: { value in
                if let error = value?.error {
                    let retError = APIServiceError(error.description ?? "Unable to find what you are looking for")
                    self.businesses = (nil, retError)
                    promise(.failure(retError))
                } else {
                    self.businesses = (value?.businesses, nil)
                    promise(.success(value?.businesses))
                }
            })
        }
    }

    // MARK: Deals services
    func fetchNearbyDeals(_ coordinates: Coordinates) -> Future<[Business]?, Error> {
        return Future<[Business]?, Error> { promise in
            let service = SearchBusinessAPIService.init(client: self.apiClient)
            service.latitude = coordinates.latitude
            service.longitude = coordinates.longitude
            service.radius = 40000
            service.attributes = ["deals"]
            service.request()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.deals = (nil, error)
                    promise(.failure(error))
                case .finished: ()
                }
            }, receiveValue: { value in
                if let error = value?.error {
                    let retError = APIServiceError(error.description ?? "Unable to find what you are looking for")
                    self.deals = (nil, retError)
                    promise(.failure(retError))
                } else {
                    self.deals = (value?.businesses, nil)
                    promise(.success(value?.businesses))
                }
            })
            .store(in: &self.bag)
        }
    }

    // MARK: Location Services
    func startLocationService() {
        locationService.startService()
        locationService.$coordinates.sink { coordinates in
            if let coordinatesValue = coordinates {
                _ = self.fetchNearbyDeals(coordinatesValue)
            }
        }
        .store(in: &bag)
    }
    func stopLocationService() {
        locationService.stopService()
    }

    // MARK: Other
    func sortBusinesses() {
        self.businesses.value = self.businesses.value?.sorted(by: { (businessA, businessB) -> Bool in
            var valueA: Double
            var valueB: Double
            switch sortType {
            case .distance:
                valueA = businessA.distance ?? 0
                valueB = businessB.distance ?? 0
            case .rating:
                valueA = businessA.rating ?? 0
                valueB = businessB.rating ?? 0
            }
            return isSortedAscending ? valueA < valueB : valueA > valueB
        })
    }
}
