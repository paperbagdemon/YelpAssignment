//
//  Location.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Location: Decodable {
    public var addressOne: String?
    public var addressTwo: String?
    public var addressThree: String?
    public var city: String?
    public var state: String?
    public var zipCode: String?
    public var country: String?
    public var displayAddress: [String]?
    public var crossStreets: String?
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
