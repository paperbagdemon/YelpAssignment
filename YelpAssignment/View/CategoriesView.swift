//
//  CategoriesView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    var categories: [Category]
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
                ForEach(0..<categories.count) { index in
                    Text(self.categories[index].alias ?? "")
                        .font(.system(size: 12))
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categories: [Category.init(alias: "filipino", title: "Filipino"),
                                    Category.init(alias: "seafood", title: "Seafood"),
                                    Category.init(alias: "fruit", title: "Fruit")])
    }
}
