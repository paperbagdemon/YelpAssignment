//
//  SearchBarView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    typealias OnTextChangedHandler = (String) -> Void
    @State private var searchText = ""
    var placeholder = "search"
    var onTextChanged: OnTextChangedHandler?
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField(placeholder, text: $searchText, onEditingChanged: { _ in
                    print("onEditingChanged")
                }, onCommit: {
                    self.onTextChanged?(self.searchText)
                    print("onCommit")
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                })
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
