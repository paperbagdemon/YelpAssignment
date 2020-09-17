//
//  ReviewAPIService.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct ReviewAPIServiceResult: Decodable {
    var total: Int?
    var reviews: [Review]?
    var possibleLanguages: [String]?
    var error: APIError?
    enum CodingKeys: String, CodingKey {
        case total
        case reviews
        case possibleLanguages  =   "possible_languages"
        case error
    }
}

class ReviewAPIService: APIService<ReviewAPIServiceResult> {
    var businessId: String
    override var endpoint: String {
        return "/businesses/\(businessId)/reviews"
    }
    init(client: APIClient, businessId: String) {
        self.businessId = businessId
        super.init(client: client)
    }
}
