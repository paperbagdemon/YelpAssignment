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
    @Published private(set) var business: Business?
    @Published private(set) var reviews: [Review]?
    @Published private(set) var detailServiceError: Error?
    @Published private(set) var reviewsServiceError: Error?
    private(set) var businessID: String
    init(apiClient: APIClient, businessID: String) {
        self.businessID = businessID
        self.apiClient = apiClient
    }
    func fetchBusinessDetail() {
        let service = BusinessDetailAPIService.init(client: self.apiClient, businessId: self.businessID)
        service.request(completion: { data, error in
            self.business = data
            self.detailServiceError = error
        })
    }
    func fetchBusinessReviews() {
        let service = ReviewAPIService.init(client: self.apiClient, businessId: self.businessID)
        service.request(completion: { data, error in
            self.reviews = data?.reviews
            self.reviewsServiceError = error
        })
    }
    convenience init(apiClient: APIClient, businessID: String, business: Business? = nil, reviews: [Review]? = nil) {
        self.init(apiClient: apiClient, businessID: businessID)
        self.business = business
        self.reviews = reviews
    }
}
