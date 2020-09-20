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
            VStack(spacing: 2) {
                Spacer()
                HStack {
                    Text(review.user.name)
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(Color.red)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .lineLimit(1)
                    Spacer()
                }
                HStack(spacing: 20) {
                    VStack {
                        GeometryReader { _ in
                            WebImage(url: URL(string: review.user.imageURL ?? ""))
                            .resizable()
                            .placeholder(Image(systemName: "person"))
                            .indicator(.activity)
                            .transition(.fade)
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipped()
                            .cornerRadius(3)
                        }
                    }.frame(width: 75, height: 75)
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                    VStack {
                        HStack {
                            StarRatingView(rating: Double(review.rating), size: 14)
                            Spacer()
                        }
                        HStack {
                            Text(review.text)
                            .font(.system(size: 14))
                            Spacer()
                        }
                        Spacer()
                    }
                }
                Divider()
            }
            .frame(maxWidth: .infinity, maxHeight: 130)
        )
    }
    func buildBodyView() -> AnyView {
        if let reviews = self.reviews {
            if !reviews.isEmpty {
                return AnyView(
                    VStack {
                        HStack {
                            Image(systemName: "captions.bubble")
                            .resizable()
                            .frame(width: 20, height: 20)
                            Text("Reviews")
                            .bold()
                        }
                        .offset(x: 0, y: 10)
                        ForEach(reviews) { review in
                            self.buildReviewRow(review: review)
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
          text: "juju\njiji\njerjer",
          timeCreated: "2016-08-29 00:41:13",
          url: "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative" +
            "=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w"),
        Review.init(id: "3233",
          rating: 4, user: User.init(id: "3232",
        profileURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
        imageURL: "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620",
         name: "Catto"),
          text: "Went back again to this place since the last time i visited the bay area 5 months ago," +
            " and nothing has changed. Still the sketchy Mission, Still the cashier...",
          timeCreated: "2016-08-29 00:41:13",
          url: "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative" +
            "=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w")])
    }
}
