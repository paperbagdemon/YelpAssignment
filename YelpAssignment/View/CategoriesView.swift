//
//  CategoriesView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    var categories: [Category]?
    var size = 12
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if let categories = self.categories {
            if !categories.isEmpty {
                return AnyView(
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(categories) { category in
                                Text(category.alias)
                                .font(.system(size: CGFloat(self.size)))
                            }
                        }
                    }
                )
            } else {
                return AnyView(
                    EmptyView()
                )
            }
        } else {
            return AnyView(
                EmptyView()
            )
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
