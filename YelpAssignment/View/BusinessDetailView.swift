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
    var business: Business
    var body: some View {
        ZStack {
            VStack {
                MapView(coordinate: business.coordinates ?? Coordinates.init(latitude: 0, longitude: 0))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight:240, alignment: .topLeading)
                Spacer()
            }
            VStack {
                HStack {
                    WebImage(url: URL(string: business.imageUrl ?? ""))
                    .resizable()
                    .placeholder {
                        Image("shop").resizable().scaledToFit()
                    }
                    .indicator(.activity)
                    .transition(.fade)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: 120, minHeight: 0, maxHeight:120, alignment: .topLeading)
                    .scaledToFit()
                    .padding(EdgeInsets.init(top: 120, leading: 10, bottom: 0, trailing: 0))
                    Spacer()
                }
                HStack {
                    Text("categories")
                        .font(.system(size: 18))
                    .padding(EdgeInsets.init(top: 5, leading: 20, bottom: 5, trailing: 0))
                    Spacer()
                }
                HStack {
                    Text(self.business.name)
                        .font(.system(size: 24))
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: -12, trailing: 0))
                    Spacer()
                }
                HStack {
                    StarRatingView(rating: Int(business.rating ?? 0))
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing:0))
                    Spacer()
                }
                HStack {
                    Text("address")
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text("Hours")
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                Spacer()
            }
            VStack {
                HStack {
                    Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("back")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 20, height: 20)
                        .padding()
                    })
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetailView(business: Business(id: "1323", name: "Lola Basyang's", imageUrl: nil,
                                              isClosed: nil, url: nil, price: nil, phone: nil,
                                              displayPhone: nil, photos: nil, rating: 4,
                                              reviewCount: nil, categories: nil, distance: 300000,
                                              coordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512), transactions: nil))
    }
}
