//
//  HeaderView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        VStack {
            Image("yelp")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets.init(top: 20, leading: 20, bottom: 40, trailing: 20))
        }
        .background(Color.red)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
