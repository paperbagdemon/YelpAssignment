//
//  YelpBusiness.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Business: Identifiable, Decodable {
    var id: String?
    var name: String = ""
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var price: String?
    var phone: String?
    var displayPhone: String?
    var photos: [String]?
    var rating: Double?
    var reviewCount: Int?
    var categories: [Category]?
    var distance: Double?
    var coordinates: Coordinates?
    var location: Location?
    var transactions: [String]?
    var hours: [Hour]?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl       =   "image_url"
        case isClosed       =   "is_closed"
        case url
        case price
        case phone
        case displayPhone   =   "display_phone"
        case photos
        case rating
        case reviewCount    =   "review_count"
        case categories
        case distance
        case coordinates
        case location
        case transactions
        case hours
    }
}

extension Business {
    func displayAddress() -> String {
        return displayAddress(delimiter: "\n")
    }
    func displayAddress(delimiter: String) -> String {
        guard let addresses = self.location?.displayAddress else {
            return self.location?.addressOne ?? ""
        }
        var displayAddress = ""
        for address in addresses {
            if !address.isEmpty {
                displayAddress += address
                if address != addresses.last {
                    displayAddress += delimiter
                }
            }
        }
        return displayAddress
    }
}
