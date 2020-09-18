//
//  ContentView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct BusinessesHomeView: View {
    @ObservedObject var viewModel: BusinessesHomeViewModel
    @State var isSortTypeShown = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HeaderView()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 220, maxHeight: 220)
                    buildContentView()
                    .padding(EdgeInsets.init(top: 30, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                VStack {
                    SearchBarView(placeholder: "Name / Address / Cuisine",
                                  onTextChanged: { term, location, categories in
                                    self.viewModel.searchBusinesses(keyword: term, location: location, categories: categories)
                    })
                    .padding(EdgeInsets.init(top: 200, leading: 10, bottom: 0, trailing: 10))
                    .zIndex(2)
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear {
            self.viewModel.startLocationService()
        }
    }
    func buildSortSelection() -> AnyView {
        if isSortTypeShown {
            let sortCases = BusinessSortType.allCases
            return AnyView(
                VStack(spacing:5) {
                    ForEach(sortCases) { sort in
                        Button(action: {
                            self.viewModel.sortType = sort
                            self.isSortTypeShown = false
                        }, label: {
                            Text(sort.rawValue)
                            .font(.system(size: 14))
                            .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                        })
                    }
                }.background(Color(.secondarySystemBackground))
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
    func buildBusinessListView(businesses: [Business]) -> AnyView {
        return AnyView(
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.viewModel.isSortedAscending.toggle()
                        }, label: {
                            Image(systemName: self.viewModel.isSortedAscending ? "arrowtriangle.up" : "arrowtriangle.down")
                        })
                        Button(action: {

                        }, label: {
                            HStack {
                                Button(action: {
                                    self.isSortTypeShown.toggle()
                                }, label: {
                                    Text("Sort: \(self.viewModel.sortType.rawValue)")
                                    .font(.system(size: 14))
                                    .bold()
                                })
                            }
                        })
                    }
                    HStack {
                        Spacer()
                        buildSortSelection()
                        .offset(y: 30)
                        .zIndex(2)
                    }
                }
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                .zIndex(2)
                .frame(height: 20)
                List(businesses) { business in
                    NavigationLink(destination: BusinessDetailView(
                        viewModel: BusinessDetailViewModel(apiClient: APIClient.defaultClient,
                        businessID: business.id!, business: business))) {
                        BusinessListRowView(business: business)
                    }
                }
            }
        )
    }
    func buildContentView() -> AnyView {
        var returnView: AnyView
        if viewModel.businesses.error != nil {
            returnView = AnyView(
                    Text("We encountered a problem")
            )
        } else {
            if let businesses = viewModel.businesses.value {
                if !businesses.isEmpty {
                    returnView = buildBusinessListView(businesses: businesses)
                } else {
                    returnView = AnyView(
                        ZStack {
                            Image("business")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(EdgeInsets.init(top: 60, leading: 20, bottom: 40, trailing: 20))
                            .opacity(0.15)
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
                        .padding(EdgeInsets.init(top: 60, leading: 20, bottom: 40, trailing: 20))
                        .opacity(0.15)
                        Text("Search to start exploring")
                        .bold()
                        .shadow(color: .white, radius: 1)
                        .font(.system(size: 20))
                        .foregroundColor(Color.red.opacity(0.9))
                    }
                )
            }
        }
        return returnView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessesHomeView(viewModel: BusinessesHomeViewModel(apiClient: APIClient.defaultClient,
        businesses: [Stub.sampleBusiness(), Stub.sampleBusiness(),
        Stub.sampleBusiness(), Stub.sampleBusiness()]))
    }
}