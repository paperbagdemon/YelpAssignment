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
            Image("gir1")
            Text("Yelp").font(.title).fontWeight(.light)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
