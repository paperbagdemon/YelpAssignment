//
//  SearchBusinessAPIService.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Alamofire

struct SearchBusinessAPIServiceResult: Decodable {
    var total: Int
    var businesses: [Business]
    var error: APIError?
    enum CodingKeys: String, CodingKey {
        case total
        case businesses
        case error
    }
}

class SearchBusinessAPIService: APIService<SearchBusinessAPIServiceResult> {
    var term: String?
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var radius: Int?
    var categories: [String]?
    var locale: String?
    var limit: Int?
    var offset: Int?
    var sortBy: String?
    var priceTiers: [String]?
    var openNow: Bool?
    var openAt: Int?
    var attributes: [String]?
    override var parameters: Parameters {
        var parameters: Parameters = [:]
        if let term = term,
            term != "" {
            parameters["term"] = term
        }
        if let location = location,
            location != "" {
            parameters["location"] = location
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }
        if let radius = radius {
            parameters["radius"] = radius
        }
        if let categories = categories,
            categories.count > 0 {
            parameters["categories"] = categories.joined(separator: ",")
        }
        if let locale = locale,
            locale != "" {
            parameters["locale"] = locale
        }
        if let limit = limit {
            parameters["limit"] = limit
        }
        if let offset = offset {
            parameters["offset"] = offset
        }
        if let sortBy = sortBy,
            sortBy != "" {
            parameters["sort_by"] = sortBy
        }
        if let priceTiers = priceTiers,
            priceTiers.count > 0 {
            parameters["price"] = priceTiers.joined(separator: ",")
        }
        if let openNow = openNow {
            parameters["open_now"] = openNow
        }
        if let openAt = openAt {
            parameters["open_at"] = openAt
        }
        if let attributes = attributes,
            attributes.count > 0 {

            var attributesString = ""
            for attribute in attributes {
                attributesString += attribute + ","
            }
            let parametersString = String(attributesString[..<attributesString.index(before: attributesString.endIndex)])
            parameters["attributes"] = parametersString
        }
        return parameters
    }
    override var endpoint: String {
        return "/businesses/search"
    }
}
