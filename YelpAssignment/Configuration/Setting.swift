//
//  Setting.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Setting {
    static var defaultSettings = Setting(
        yelpAPIKey: "NbyfuyivUF4KhVmYHUNgh15kM7bwmLKhED97HdMsFE3pPpLMyz1TNC1NZHXhhiFVRAl" +
        "dsl_TKA0wduMhhPOwiyhW8ttUd1nXzkoc6hTUL915heQYj-JwLDNRKodgX3Yx",
        yelpBaseURL: "https://api.yelp.com/v3")
    let yelpAPIKey: String
    let yelpBaseURL: String

    lazy var categoryPresets: [Category]? = {
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Category].self, from: data)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }()
}

extension Setting {
    mutating func suggestCategory(term: String?) -> [Category] {
        if let keyword = term {
            if !keyword.isEmpty {
                let filtered = self.categoryPresets?.filter({ category -> Bool in
                    return category.title.contains(keyword)
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
