//
//  BusinessCategory.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Category: Decodable {
    public var alias: String?
    public var title: String?
    enum CodingKeys: String, CodingKey {
        case alias
        case title
    }
}
