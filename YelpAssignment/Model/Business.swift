//
//  YelpBusiness.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Business: Identifiable, Decodable {
    var id: String?
    var name: String = ""
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var price: String?
    var phone: String?
    var displayPhone: String?
    var photos: [String]?
    var rating: Double?
    var reviewCount: Int?
    var categories: [Category]?
    var distance: Double?
    var coordinates: Coordinates?
    var transactions: [String]?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl       =   "image_url"
        case isClosed       =   "is_closed"
        case url
        case price
        case phone
        case displayPhone   =   "display_phone"
        case photos
        case rating
        case reviewCount    =   "review_count"
        case categories
        case distance
        case coordinates
        case transactions
    }
}

//extension Business {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let string = try container.decode(String.self, forKey: .url)
//        guard
//            let percentEncoded = string
//                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//            let url = URL(string: percentEncoded)
//        else {
//            throw DecodingError.dataCorruptedError(forKey: .url,
//                                                   in: container,
//                debugDescription: "Invalid url string: \(string)")
//        }
//        self.url = url
//    }
//}
