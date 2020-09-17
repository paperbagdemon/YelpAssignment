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
    var start: String?
    var end: String?
    var day: Int?
    enum CodingKeys: String, CodingKey {
        case isOvernight    =   "is_overnight"
        case start          =   "start"
        case end            =   "end"
        case day            =   "day"
    }
}
