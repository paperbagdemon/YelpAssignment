//
//  BusinessDetailViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Combine

final class BusinessDetailViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    private var apiClient: APIClient!
    private(set) var locationService: LocationService!
    private(set) var businessID: String
    @Published private(set) var business: (value: Business?,error: Error?)
    @Published private(set) var reviews: (value: [Review]?,error: Error?)

    init(apiClient: APIClient, locationService: LocationService, businessID: String) {
        self.businessID = businessID
        self.apiClient = apiClient
        self.locationService = locationService
    }

    convenience init(apiClient: APIClient,locationService: LocationService = LocationService.defaultService, businessID: String, business: Business? = nil, reviews: [Review]? = nil) {
        self.init(apiClient: apiClient,locationService: locationService , businessID: businessID)
        self.business.value = business
        self.reviews.value = reviews
    }

    func fetchBusinessDetail() -> Future<Business?, Error> {
        return Future<Business?, Error> { promise in
            let service = BusinessDetailAPIService.init(client: self.apiClient, businessId: self.businessID)
            service.request()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    //do nothing
                    promise(.failure(error))
                case .finished: ()
                }
            }) { value in
                self.business = (value, nil)
                promise(.success(value))
            }
            .store(in: &self.bag)
        }
    }

    func fetchBusinessReviews(completion: (([Review]?, Error?) -> Void)? = nil) -> Future<[Review]?, Error> {
        return Future<[Review]?, Error> { promise in
            let service = ReviewAPIService.init(client: self.apiClient, businessId: self.businessID)
            service.request()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    //set empty reviews
                    self.reviews = ([], error)
                    promise(.failure(error))
                case .finished: ()
                }
            }) { value in
                self.reviews = (value?.reviews, nil)
                promise(.success(value?.reviews))
            }
            .store(in: &self.bag)
        }
    }
}
