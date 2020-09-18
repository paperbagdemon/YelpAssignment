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
    var alias: String
    var title: String
    enum CodingKeys: String, CodingKey {
        case alias
        case title
    }
    
    static var presets : [Category]? {
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Category].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension Category {
    static func suggestCategory(term: String?) -> [Category]{
        if let keyword = term {
            if !keyword.isEmpty {
                let filtered = Category.presets?.filter({ (category) -> Bool in
                    return category.title.starts(with: keyword) && category.title != keyword
                })
                return Array(filtered?.prefix(7) ?? [])
            } else {
                return []
            }
        } else {
            return []
        }
    }
}
