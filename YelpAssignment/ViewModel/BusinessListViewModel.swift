//
//  HomeViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Combine

final class BusinessListViewModel: ObservableObject {
    private var apiClient: APIClient!
    @Published private(set) var businesses: [Business]?
    @Published private(set) var error: Error?
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    func searchBusinesses(keyword: String) {
        let service = SearchBusinessAPIService.init(client: self.apiClient)
        service.location = keyword
        service.term = keyword
        service.radius = 20000
        service.request(completion: { data, error in
            self.businesses = data?.businesses
            self.error = error
        })
    }
}
