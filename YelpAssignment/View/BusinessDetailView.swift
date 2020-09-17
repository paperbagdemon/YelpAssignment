//
//  BusinessDetailView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BusinessDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: BusinessDetailViewModel
    var body: some View {
        buildBodyView()
            .onAppear {
                self.viewModel.fetchBusinessDetail()
                self.viewModel.fetchBusinessReviews()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func buildBodyView() -> AnyView {
        if let business = viewModel.business {
            return AnyView(
                ScrollView {
                    VStack{
                        ZStack {
                            VStack {
                                WebImage(url: URL(string: business.imageUrl ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade)
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                            }
                            VStack{
                                HStack {
                                    Text(business.name)
                                    .font(.system(size: 24))
                                        .fontWeight(.bold)
                                    .padding(EdgeInsets.init(top: 120, leading: 20, bottom: 0, trailing: 0))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                HStack {
                                    StarRatingView(rating: Int(business.rating ?? 0))
                                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 10, trailing:0))
                                    Spacer()
                                }
                            }
                            VStack {
                                HStack {
                                    Button(action: {
                                      self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .padding()
                                    })
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.3))
                        HStack {
                            buildCategoryView()
                                .font(.system(size: 18))
                            .padding(EdgeInsets.init(top: 5, leading: 20, bottom: 5, trailing: 0))
                            Spacer()
                        }
                        MapView(coordinate: business.coordinates ?? Coordinates.init(latitude: 0, longitude: 0))
                        .frame(height: 160)
                        .disabled(true)
                        HStack {
                            VStack {
                                Text(business.displayAddress())
                                    .font(.system(size: 14))
                                .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                            }
                            Spacer()
                            HoursView(hours: business.hours)
                            .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                        HStack {
                            PhoneNumbersView(phoneNumber: viewModel.business?.phone)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        ReviewsView(reviews: viewModel.reviews)
                        Spacer()
                    }
                }
            )
        } else{
            return AnyView(
                VStack {
                    Image("gir2")
                    Text("loading...")
                }
            )
        }
    }
    
    func buildCategoryView() -> AnyView {
        if let categories = viewModel.business?.categories {
            return AnyView(
                CategoriesView(categories: categories)
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        use this url to test image loding
//        imageUrl: "https://s3-media1.fl.yelpcdn.com/bphoto/zVCoHsMZebOXgM9uZDIWKw/o.jpg"
//        BusinessDetailView(viewModel: BusinessDetailViewModel.init(apiClient: APIClient.defaultClient,
//        businessID: "sFKF4eyP6DKdr2o1qpykig"))


        BusinessDetailView(viewModel: BusinessDetailViewModel.init(apiClient: APIClient.defaultClient,
                                                                   businessID: "sFKF4eyP6DKdr2o1qpykig",
                                                                   business: Business(id: "sFKF4eyP6DKdr2o1qpykig", name: "Lola Basyang's", imageUrl: nil,
                                                                   isClosed: nil, url: nil, price: nil, phone: "+639228177570",
                                                                   displayPhone: "+639228177570", photos: nil, rating: 4,
                                                                   reviewCount: nil, categories: [Category.init(alias: "Filipino", title: "Filipino"),
                                                                   Category.init(alias: "Seafood", title: "Seafood"),
                                                                   Category.init(alias: "Fruit", title: "Fruit"),
                                                                   Category.init(alias: "Meat", title: "Meat"),
                                                                    Category.init(alias: "Street", title: "Street"),Category.init(alias: "Meal", title: "Meal")], distance: 300000, coordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512), location: Location(addressOne: "Jupiter Street", addressTwo: "G/F, Executive Building", addressThree: nil, city: "Makati", state: "NCR", zipCode: "", country: "PH", displayAddress: ["Jupiter Street","G/F, Executive Building","Makati, Metro Manila","Philippines"], crossStreets: nil), transactions: nil, hours: [Hour.init(hoursType: "Regular",
                                                                                                open: [Open.init(isOvernight: true, start: "1000", end: "2100", day: 0),
                                                                    Open.init(isOvernight: true, start: "1000", end: "2100", day: 1),
                                                                    Open.init(isOvernight: true, start: "1000", end: "2100", day: 2),
                                                                    Open.init(isOvernight: true, start: "1000", end: "2100", day: 3),
                                                                    Open.init(isOvernight: true, start: "1000", end: "2100", day: 4),
                                                                    Open.init(isOvernight: true, start: "1000", end: "2100", day: 5)])]),
                                                                   reviews: [Review.init(id: "3233",
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
                                                                     name: "Catta"),
                                                                      text: "Went back again to this place since the last time i visited the bay area 5 months ago," +
                                                                        " and nothing has changed. Still the sketchy Mission, Still the cashier...",
                                                                      timeCreated: "2016-08-29 00:41:13",
                                                                      url: "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative" +
                                                                        "=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w")]))
    }
}
