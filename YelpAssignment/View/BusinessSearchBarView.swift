//
//  SearchBarView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import Combine

class BusinessSearchBarViewEvents {
    var bag = Set<AnyCancellable>()
}

struct BusinessSearchBarView: View {
    typealias OnSearchHandler = (_ term: String, _ location: String, _ categories: [String]?) -> Void
    @State var isLocationSearchShown = false
    @State var isCategoryShown = false
    @State var updater = false
    var placeholder = "Find"
    var locationPlaceholder = "Current Location"
    var categoryPlaceholder = "Any Category"
    @ObservedObject var viewModel: BusinessSearchBarViewModel
    var events = BusinessSearchBarViewEvents()
    var onSearch: OnSearchHandler?

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Button(action: {
                    self.onSearch?(self.viewModel.termQuery, self.viewModel.locationQuery, [self.viewModel.categoryQuery])
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
                TextField(placeholder, text: Binding(get: {
                    self.viewModel.termQuery
                }, set: { value in
                    self.viewModel.termQuery = value
                }), onEditingChanged: { _ in
                    print("")
                }, onCommit: {
                    self.onSearch?(self.viewModel.termQuery, self.viewModel.locationQuery, [self.viewModel.categoryQuery])
                    self.isLocationSearchShown = false
                    self.isCategoryShown = false
                }).foregroundColor(.primary)
                .onTapGesture {
                        print("focus")
                }
                .accessibility(identifier: "businessSearchBarView.textFieldSearchTerm")
                Button(action: {
                    self.viewModel.termQuery = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill").opacity(viewModel.termQuery == "" ? 0 : 1)
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
            buildAutoSuggestList()
            Spacer()
        }
        .onAppear {
            self.viewModel.$locationQuery
            .removeDuplicates()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { val in
                if !val.isEmpty, val.count > 3 {
                    self.viewModel.getLocations(term: self.viewModel.locationQuery)
                }
            }
            .store(in: &self.events.bag)
        }
    }

    func buildLocationSearchBar() -> AnyView {
        if isLocationSearchShown {
            return AnyView(
                HStack {
                    Button(action: {
                        self.isLocationSearchShown.toggle()
                    }, label: {
                        Image(systemName: isLocationSearchShown ? "pin.fill" : "pin")
                    })
                    TextField(locationPlaceholder, text: Binding(get: {
                        self.viewModel.locationQuery
                    }, set: { value in
                        self.viewModel.locationQuery = value
                    }), onEditingChanged: { _ in

                    }, onCommit: {
                        self.onSearch?(self.viewModel.termQuery, self.viewModel.locationQuery, [self.viewModel.categoryQuery])
                        self.isLocationSearchShown = false
                        self.isCategoryShown = false
                    })
                    .foregroundColor(.primary)

                    Button(action: {
                        self.viewModel.locationQuery = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill").opacity(self.viewModel.locationQuery == "" ? 0 : 1)
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
                    HStack(alignment: .top) {
                        Button(action: {
                            self.isCategoryShown.toggle()
                        }, label: {
                            Image(systemName: isCategoryShown ? "rectangle.3.offgrid.fill" : "rectangle.3.offgrid")
                        })
                        TextField(categoryPlaceholder, text: Binding(get: {
                            self.viewModel.categoryQuery
                        }, set: { value in
                            self.viewModel.categoryQuery = value
                            self.viewModel.objectWillChange.send()
                        }), onEditingChanged: { _ in
                            print("")
                        }, onCommit: {
                            self.onSearch?(self.viewModel.termQuery, self.viewModel.locationQuery, [self.viewModel.categoryQuery])
                            self.isLocationSearchShown = false
                            self.isCategoryShown = false
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.viewModel.categoryQuery = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").opacity(self.viewModel.categoryQuery == "" ? 0 : 1)
                        })
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(3.0)
                }
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
    func buildAutoSuggestList() -> AnyView {
        var suggestStrings: [String]?

        switch viewModel.suggestType {
        case .term:
            suggestStrings = []
        case .category:
            if !self.isCategoryShown {
                return AnyView(EmptyView())
            }
            suggestStrings = Category.suggestCategory(term: self.viewModel.categoryQuery).map({ value -> String in
                return value.alias
            })
        case .location:
            if !self.isLocationSearchShown {
                return AnyView(EmptyView())
            }

            suggestStrings = self.viewModel.locations.value?.map({ value -> String in
                return value.qualifiedName ?? ""
            })
        case .none: ()
        }

        if let values = suggestStrings, !values.isEmpty {
            return AnyView(
                VStack {
                    ForEach(values, id:\.self) { value in
                        VStack(spacing: 0) {
                            HStack {
                                Button(action: {
                                    switch self.viewModel.suggestType {
                                    case .term:
                                        self.viewModel.termQuery = value
                                        self.viewModel.suggestType = .none
                                    case .category:
                                        self.viewModel.categoryQuery = value
                                        self.viewModel.suggestType = .none
                                    case .location:
                                        self.viewModel.locationQuery = value
                                        self.viewModel.suggestType = .none
                                    case .none: ()
                                    }
                                }, label: {
                                    Text(value)
                                    .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                                })
                                .padding(EdgeInsets.init(top: 0, leading: 35, bottom: 0, trailing: 0))
                                Spacer()
                            }
                            Divider()
                        }
                        .background(Color(.secondarySystemBackground))
                    }
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSearchBarView(viewModel: BusinessSearchBarViewModel.init(locationService: LocationService.defaultService))
    }
}
