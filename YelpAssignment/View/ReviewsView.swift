//
//  ReviewsView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewsView: View {
    var reviews: [Review]?
    var body: some View {
        buildBodyView()
    }
    func buildReviewRow(review: Review) -> AnyView {
        return AnyView(
            VStack {
                HStack(spacing: 20) {
                    VStack {
                        HStack {
                            Text(review.user.name)
                            .font(.system(size: 14))
                            .bold()
                            .foregroundColor(Color.red)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .lineLimit(1)
                            Spacer()
                        }
                        WebImage(url: URL(string: review.user.imageURL ?? ""))
                        .resizable()
                        .placeholder(Image(systemName: "mustache.fill"))
                        .indicator(.activity)
                        .transition(.fade)
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }
                    .frame(minWidth: 60, maxWidth: 60, minHeight: 100, idealHeight: 120, maxHeight: 180)
                    VStack {
                        HStack {
                            StarRatingView(rating: review.rating, size: 14)
                            Spacer()
                        }
                        Text(review.text)
                        .font(.system(size: 14))
                    }
                }
                Divider()
            }
        )
    }
    func buildBodyView() -> AnyView {
        if let reviews = self.reviews {
            return AnyView(
                VStack {
                    HStack {
                        Image(systemName: "captions.bubble")
                        .resizable()
                        .frame(width: 20, height: 20)
                        Text("Reviews")
                        .bold()
                    }
                    ForEach(0..<reviews.count) { index in
                        self.buildReviewRow(review: reviews[index])
                    }
                }
            )
        } else {
            return AnyView(
                VStack {
                    Image(systemName: "captions.bubble")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text("There are no reviews at the moment")
                }
            )
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(reviews: [Review.init(id: "3233",
                                          rating: 4, user: User.init(id: "3232",
                                        profileURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
                                        imageURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
                                         name: "Catto"),
                                          text: "Went back again to this place since the last time i visited the bay area 5 months ago," +
                                            " and nothing has changed. Still the sketchy Mission, Still the cashier...",
                                          timeCreated: "2016-08-29 00:41:13",
                                          url: "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative" +
                                            "=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w"),
        Review.init(id: "32333",
          rating: 2, user: User.init(id: "32332",
        profileURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
        imageURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
         name: "Cattastropghe"),
          text: "Went back again to this place since the last time i visited the bay area 5 months ago," +
            " and nothing has changed. Still the sketchy Mission, Still the cashier...",
          timeCreated: "2016-08-29 00:41:13",
          url: "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative" +
            "=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w")])
    }
}
