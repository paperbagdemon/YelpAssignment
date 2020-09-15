//
//  YelpError.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct APIError: Decodable {
    public var description: String?
    public var field: String?
    public var code: String?
    enum CodingKeys: String, CodingKey {
        case description
        case field
        case code
    }
}
