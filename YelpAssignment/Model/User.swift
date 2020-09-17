//
//  User.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: String?
    var profileURL: String?
    var imageURL: String?
    var name: String
    enum CodingKeys: String, CodingKey {
        case id
        case profileURL =   "profile_url"
        case imageURL   =   "image_url"
        case name
    }
}
