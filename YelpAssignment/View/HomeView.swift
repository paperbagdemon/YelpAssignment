//
//  ContentView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct BusinessListView: View {
    @ObservedObject var viewModel = BusinessListViewModel(service: APIClient.defaultClient)
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                SearchBarView(placeholder: "Name / Address / Cuisine",
                              onTextChanged: { text in
                                self.viewModel.searchBusiness(keyword: text)
                    })
                    .offset(x: 0, y: -30)
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                bodyView()
                    .padding(EdgeInsets.init(top: -30, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
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
                            NavigationLink(destination: BusinessDetailView(business: business)) {
                                Text(business.name)
                            }
                    })
                } else {
                    returnView = AnyView(
                        ZStack {
                            Image("business")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(EdgeInsets.init(top: 20, leading: 20, bottom: 40, trailing: 20))
                            Text("We didn't find what you are looking for")
                            .shadow(color: .white, radius: 1)
                        }
                    )
                }
            } else {
                returnView = AnyView(
                    ZStack {
                        Image("business")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets.init(top: 20, leading: 20, bottom: 40, trailing: 20))
                        Text("Begin searching for business")
                        .shadow(color: .white, radius: 1)
                    }
                )
            }
        }
        return returnView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
