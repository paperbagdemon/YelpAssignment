//
//  BusinessListRowView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BusinessListRowView: View {
    var business: Business
    var body: some View {
        HStack {
            WebImage(url: URL(string: business.imageUrl ?? ""))
            .resizable()
            .placeholder(Image("shop"))
            .indicator(.activity)
            .transition(.fade)
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipped()
            .cornerRadius(3)
            VStack(alignment: .leading, spacing: 2, content: {
                Text(business.name)
                .bold()
                HStack(spacing: 0) {
                    PriceView(price: business.price)
                    StarRatingView(rating: Int(business.rating ?? 0), size: 12)
                }
                CategoriesView(categories: business.categories)
                Text(business.displayAddress(delimiter: ","))
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                Spacer()
            })
        }
        .frame(height: 100)
    }
}

struct BusinessListRowView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListRowView(business: Business(id: "sFKF4eyP6DKdr2o1qpykig", name: "Lola Basyang's", imageUrl: "https://s3-media1.fl.yelpcdn.com/bphoto/zVCoHsMZebOXgM9uZDIWKw/o.jpg",
            isClosed: nil, url: nil, price: "₱₱", phone: "+639228177570",
            displayPhone: "+639228177570", photos: nil, rating: 4,
            reviewCount: nil, categories: [Category.init(alias: "Filipino", title: "Filipino"),
            Category.init(alias: "Seafood", title: "Seafood"),
            Category.init(alias: "Fruit", title: "Fruit"),
            Category.init(alias: "Meat", title: "Meat"),
            Category.init(alias: "Street", title: "Street"),
            Category.init(alias: "Meal", title: "Meal")],
            distance: 300000,
            coordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512),
            location: Location(addressOne: "Jupiter Street", addressTwo: "G/F, Executive Building", addressThree: nil, city: "Makati", state: "NCR", zipCode: "", country: "PH",
            displayAddress: ["Jupiter Street", "G/F, Executive Building", "Makati, Metro Manila", "Philippines"],
            crossStreets: nil), transactions: nil, hours: [Hour.init(hoursType: "Regular",
            open: [Open.init(isOvernight: true, start: "1000", end: "2100", day: 0),
            Open.init(isOvernight: true, start: "1000", end: "2100", day: 1),
            Open.init(isOvernight: true, start: "1000", end: "2100", day: 2),
            Open.init(isOvernight: true, start: "1000", end: "2100", day: 3),
            Open.init(isOvernight: true, start: "1000", end: "2100", day: 4),
            Open.init(isOvernight: true, start: "1000", end: "2100", day: 5)])]))
    }
}
