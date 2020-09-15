//
//  Location.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Location: Decodable {
    var addressOne: String?
    var addressTwo: String?
    var addressThree: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var country: String?
    var displayAddress: [String]?
    var crossStreets: String?
    enum CodingKeys: String, CodingKey {
        case addressOne     =   "address1"
        case addressTwo     =   "address2"
        case addressThree   =   "address3"
        case city
        case state
        case zipCode        =   "zip_code"
        case country        =   "country"
        case displayAddress =   "display_address"
        case crossStreets   =   "cross_streets"
    }
}
