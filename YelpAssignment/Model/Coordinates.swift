//
//  Coordinate.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Coordinates: Decodable {
    public var latitude: Double?
    public var longitude: Double?
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
