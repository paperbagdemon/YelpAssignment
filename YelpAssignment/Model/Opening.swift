//
//  Opening.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Open: Decodable {
    var isOvernight: Bool?
    var end: String?
    var day: Int?
    var start: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        isOvernight <- map["is_overnight"]
        end         <- map["end"]
        day         <- map["day"]
        start       <- map["start"]
    }
}

