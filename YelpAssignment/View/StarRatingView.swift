//
//  StarRatingView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct StarRatingView: View {
    var rating = 4.5
    var size = 18
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        return AnyView(
            HStack(spacing: 4) {
                ForEach(0..<Int(floor(rating)), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.yellow)
                        .scaledToFill()
                        .frame(width: CGFloat(self.size), height: CGFloat(self.size))
                }
                if rating - floor(rating) > 0 {
                    Image(systemName: "star.fill")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.yellow)
                    .scaledToFill()
                    .frame(width: CGFloat(self.size/2), height: CGFloat(self.size))
                    .offset(x: CGFloat(self.size/4))
                    .clipped()
                }
            }
        )
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 3.5)
    }
}
