//
//  BusinessDetailViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

final class BusinessDetailViewModel: ObservableObject {
    private var apiClient: APIClient!
    @Published private(set) var business: (value: Business?,error: Error?)
    @Published private(set) var reviews: (value: [Review]?,error: Error?)
    private(set) var businessID: String
    init(apiClient: APIClient, businessID: String) {
        self.businessID = businessID
        self.apiClient = apiClient
    }
    func fetchBusinessDetail(completion: ((Business?, Error?) -> Void)? = nil) {
        let service = BusinessDetailAPIService.init(client: self.apiClient, businessId: self.businessID)
        service.request(completion: { data, error in
            self.business = (data, error)
            completion?(data, error)
        })
    }
    func fetchBusinessReviews(completion: (([Review]?, Error?) -> Void)? = nil) {
        let service = ReviewAPIService.init(client: self.apiClient, businessId: self.businessID)
        service.request(completion: { data, error in
            self.reviews = (data?.reviews, error)
            completion?(data?.reviews, error)
        })
    }
    convenience init(apiClient: APIClient, businessID: String, business: Business? = nil, reviews: [Review]? = nil) {
        self.init(apiClient: apiClient, businessID: businessID)
        self.business.value = business
        self.reviews.value = reviews
    }
}
