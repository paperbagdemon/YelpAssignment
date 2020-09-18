//
//  PhotosRollView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosRollView: View {
    var photos: [String]?
    var size = 60
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if let photos = self.photos {
            if photos.count >= 2 {
                return AnyView(
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(0..<photos.count) { index in
                                WebImage(url: URL(string: photos[index]))
                                .resizable()
                                .placeholder(Image(systemName: "list.bullet.below.rectangle"))
                                .indicator(.activity)
                                .transition(.fade)
                                .scaledToFill()
                                    .frame(width: CGFloat(self.size), height: CGFloat(self.size))
                                .clipped()
                                .cornerRadius(3)
                            }
                        }
                    }
                )
            } else {
                return AnyView(
                    EmptyView()
                )
            }
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }

}

struct PhotosRollView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosRollView(photos: [Stub.testPhotoURL, Stub.testPhotoURL])
    }
}
