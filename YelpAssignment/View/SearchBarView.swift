//
//  SearchBarView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    typealias OnTextChangedHandler = (_ term: String, _ location: String, _ categories: [String]?) -> Void
    @State private var searchText = ""
    var placeholder = "search"
    @State private var locationText = ""
    var locationPlaceholder = "Current Location"
    @State var isLocationSearchShown = false
    @State private var categoryText = ""
    var categoryPlaceholder = "Any Category"
    @State var isCategoryShown = false
    var onTextChanged: OnTextChangedHandler?
    var body: some View {
        VStack (alignment: .leading, spacing: 1){
            HStack {
                Image(systemName: "magnifyingglass")

                TextField(placeholder, text: $searchText, onEditingChanged: { _ in
                    print("")
                }, onCommit: {
                    self.onTextChanged?(self.searchText, self.locationText, !self.categoryText.isEmpty ? [self.categoryText] : nil)
                    self.isLocationSearchShown = false
                    self.isCategoryShown = false
                }).foregroundColor(.primary)
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                })
                Button(action: {
                    self.isLocationSearchShown.toggle()
                }, label: {
                    Image(systemName: isLocationSearchShown ? "pin.fill" : "pin")
                })
                Button(action: {
                    self.isCategoryShown.toggle()
                }, label: {
                    Image(systemName: isCategoryShown ? "rectangle.3.offgrid.fill" : "rectangle.3.offgrid")
                })
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(3.0)
            buildLocationSearchBar()
            buildCategoriesBar()
        }
    }
    
    func buildLocationSearchBar() -> AnyView{
        if isLocationSearchShown {
            return AnyView(
                HStack {
                    Button(action: {
                        self.isLocationSearchShown.toggle()
                    }, label: {
                        Image(systemName: isLocationSearchShown ? "pin.fill" : "pin")
                    })
                    TextField(locationPlaceholder, text: $locationText, onEditingChanged: { _ in
                        print("")
                    }, onCommit: {
                        self.onTextChanged?(self.searchText, self.locationText, !self.categoryText.isEmpty ? [self.categoryText] : nil)
                        self.isLocationSearchShown = false
                        self.isCategoryShown = false
                    }).foregroundColor(.primary)
                    Button(action: {
                        self.locationText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill").opacity(locationText == "" ? 0 : 1)
                    })
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(3.0)
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
    func buildCategoriesBar() -> AnyView {
        if isCategoryShown {
            return AnyView(
                VStack(alignment: .center) {
                    HStack (alignment: .top){
                        Button(action: {
                            self.isCategoryShown.toggle()
                        }, label: {
                            Image(systemName: isCategoryShown ? "rectangle.3.offgrid.fill" : "rectangle.3.offgrid")
                        })
                        TextField(categoryPlaceholder, text: $categoryText, onEditingChanged: { _ in
                            print("")
                        }, onCommit: {
                            self.onTextChanged?(self.searchText, self.locationText, !self.categoryText.isEmpty ? [self.categoryText] : nil)
                            self.isLocationSearchShown = false
                            self.isCategoryShown = false
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.categoryText = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").opacity(categoryText == "" ? 0 : 1)
                        })
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(3.0)
                    buildAutoSuggestList()
                }
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
    func buildAutoSuggestList() -> AnyView {
        let categories = Category.suggestCategory(term: categoryText)
        if categories.count > 0 {
            return AnyView(
                VStack {
                    ForEach(categories, id: \.alias) { category in
                        HStack {
                            Button(action: {
                                self.categoryText = category.alias
                            }, label: {
                                Text(category.alias)
                                .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                            })
                                .padding(EdgeInsets.init(top: 0, leading: 35, bottom: 0, trailing: 0))
                            Spacer()
                        }
                    }
                }
                .background(Color(.secondarySystemBackground))
            )
        } else {
            return AnyView (
                EmptyView()
            )
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
