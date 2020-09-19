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
    convenience init(apiClient: APIClient, businesses: [Business]? = nil) {
        self.init(apiClient: apiClient)
        self.businesses.value = businesses
    }
    //MARK: Lifecycle
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    //MARK: Business services
    func searchBusinesses(keyword: String? = nil, location: String? = nil, categories: [String]? = nil, attributes: [String]? = nil, completion: (([Business]?, Error?) -> Void)? = nil) {
        guard let keyword = keyword?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
            return
        }
        let service = SearchBusinessAPIService.init(client: self.apiClient)
        if let locationValue = location?.trimmingCharacters(in: .whitespacesAndNewlines), !locationValue.isEmpty {
            service.location = locationValue
        } else if let coordinates = locationService.coordinates {
            service.latitude = coordinates.latitude
            service.longitude = coordinates.longitude
        } else {
            businesses = (nil, LocationError("Location is not provided, please enter a location in search bar or enable location services."))
            completion?(businesses.value, businesses.error)
            return
        }
        service.term = keyword
        service.categories = categories
        service.radius = 40000
        service.attributes = attributes
        service.request(completion: { data, error in
            self.businesses = (data?.businesses, error)
            self.sortBusinesses()
            completion?(data?.businesses, error)
        })
    }
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
    //MARK: Deals services
    func fetchNearbyDeals(_ coordinates: Coordinates, completion: (([Business]?, Error?) -> Void)? = nil){
        let service = SearchBusinessAPIService.init(client: self.apiClient)
        service.latitude = coordinates.latitude
        service.longitude = coordinates.longitude
        service.radius = 40000
        service.attributes = ["deals"]
        service.request(completion: { data, error in
            self.deals = (data?.businesses, error )
            completion?(self.deals.value, self.deals.error)
        })
    }
    // MARK: Location Services
    func startLocationService() {
        locationService.startService()
        locationService.$coordinates.sink { coordinates in
            if let coordinatesValue = coordinates {
                self.fetchNearbyDeals(coordinatesValue)
            }
        }
        .store(in: &bag)
    }
    func stopLocationService() {
        locationService.stopService()
    }
}
