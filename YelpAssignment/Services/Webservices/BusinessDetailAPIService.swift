//
//  SearchBusinessAPIService.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Alamofire

class BusinessDetailAPIService: APIService<Business> {
    var businessId: String
    var locale: String?
    override var parameters: Parameters {
        var parameters: Parameters = [:]
        if let locale = locale,
            locale != "" {
            parameters["locale"] = locale
        }
        return parameters
    }
    override var endpoint: String {
        return "/businesses/\(businessId)"
    }
    init(client: APIClient, businessId: String) {
        self.businessId = businessId
        super.init(client: client)
    }
}
