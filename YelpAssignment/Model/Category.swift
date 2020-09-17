//
//  BusinessCategory.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Category: Identifiable, Decodable {
    var id = UUID()
    var alias: String?
    var title: String?
    enum CodingKeys: String, CodingKey {
        case alias
        case title
    }
}
