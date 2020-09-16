//
//  StarRatingView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct StarRatingView: View {
    var rating = 5
    var body: some View {
        HStack {
            ForEach(0..<rating) { _ in
                Image(systemName: "star.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 2)
    }
}
