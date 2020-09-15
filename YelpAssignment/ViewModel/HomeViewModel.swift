//
//  HomeViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    private var apiService: APIClient!
    @Published private(set) var businesses: [Business]?
    @Published private(set) var error: Error?
    var service: SearchBusinessAPIService?
    init(service: APIClient) {
        apiService = service
    }
    func searchBusiness(keyword: String) {
        service = SearchBusinessAPIService.init(client: APIClient.defaultClient)
        service?.location = keyword
        service?.term = keyword
        service?.radius = 20000
        service?.request(completion: { data, error in
            self.businesses = data?.businesses
            self.error = error
        })
    }
}
