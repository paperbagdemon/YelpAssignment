//
//  DealsBannerView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/18/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct DealsBannerView: View {
    var deals: [Business]?
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if let deals = self.deals {
            if !deals.isEmpty {
                return AnyView(
                    ScrollView {
                        ForEach(deals, id: \.id) { deal in
                            Text(deal.name)
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

struct DealsBannerView_Previews: PreviewProvider {
    static var previews: some View {
        DealsBannerView(deals: [Stub.sampleBusiness(), Stub.sampleBusiness()])
    }
}
