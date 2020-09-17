//
//  Review.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Review: Identifiable, Decodable {
    var id: String
    var rating: Int
    var user: User
    var text: String
    var timeCreated: String
    var url: String
    enum CodingKeys: String, CodingKey {
        case id
        case rating
        case user
        case text
        case timeCreated    =   "time_created"
        case url
    }
}
