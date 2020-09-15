//
//  ContentView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel(service: APIClient.defaultClient)
    var body: some View {
        VStack {
            HeaderView()
            SearchBarView(placeholder: "Name / Address / Cuisine",
                          onTextChanged: { text in
                            self.viewModel.searchBusiness(keyword: text)
                }
            )
            bodyView()
            Spacer()
        }
    }
    func bodyView() -> AnyView {
        var returnView: AnyView
        if viewModel.error != nil {
            returnView = AnyView(
                    Text("We encountered a problem")
            )
        } else {
            if let businesses = viewModel.businesses {
                if !businesses.isEmpty {
                    returnView = AnyView(
                        List(businesses) { business in
                            Text(business.name)
                    })
                } else {
                    returnView = AnyView(
                            Text("We didn't find what you are looking for")
                    )
                }
            } else {
                returnView = AnyView(
                        Text("Begin searching for business")
                )
            }

        }
        return returnView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
