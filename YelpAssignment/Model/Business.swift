//
//  YelpBusiness.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Business: Identifiable, Decodable {
    public var id: String?
    public var name: String = ""
    public var imageUrl: String?
    public var isClosed: Bool?
    public var url: String?
    public var price: String?
    public var phone: String?
    public var displayPhone: String?
    public var photos: [String]?
    public var rating: Double?
    public var reviewCount: Int?
    public var categories: [Category]?
    public var distance: Double?
    public var coordinates: Coordinates?
    public var transactions: [String]?
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
