//
//  PriceView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct PriceView: View {
    var price: String?
    var size: Int = 12
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if let price = self.price {
            if !price.isEmpty {
                return AnyView(
                    Text("\(price) · ")
                        .font(.system(size: CGFloat(size)))
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

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: "PP")
    }
}
