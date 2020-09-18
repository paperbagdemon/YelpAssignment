//
//  DealsBannerView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/18/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import SwiftUIPager
import SDWebImageSwiftUI

struct DealsBannerView: View {
    var deals: [Business]?
    @State var page = 0
    let timer = Timer.publish(every: 12, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            self.buildPagerView()
                .onReceive(timer) { _ in
                    withAnimation {
                        if let deals = self.deals {
                            if self.page < deals.count - 1 {
                                self.page += 1
                            } else {
                                self.page = 0
                            }
                        }
                    }
            }
            VStack {
                HStack {
                    Text("Explore deals near you")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black, radius: 2, x: 1, y: 1)
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
    func buildPagerView() -> AnyView {
        if let deals = self.deals {
            if !deals.isEmpty {
                return AnyView(
                    Pager(page: $page,
                          data: deals,
                          id: \.self) {
                            self.buildBannerView(business: $0)
                    }
                    .pagingPriority(.simultaneous)
                    .loopPages()
                    .itemSpacing(10)
                    .background(Color.gray.opacity(0.2))
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
    func buildBannerView(business: Business) -> AnyView {
        return AnyView (
            Button(action: {

            }, label: {
                ZStack {
                    GeometryReader { geo in
                        WebImage(url: URL(string: business.imageUrl ?? ""))
                        .resizable()
                        .placeholder(Image("shop"))
                        .indicator(.activity)
                        .transition(.fade)
                        .scaledToFill()
                        .frame(width: geo.size.width)
                    }
                    VStack {
                        HStack{
                            Text(business.name)
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                            .shadow(color: Color.black, radius: 2, x: 1, y: 1)
                            .padding(EdgeInsets.init(top: 50, leading: 30, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        Spacer()
                    }
                }
            })


        )
    }
}

struct DealsBannerView_Previews: PreviewProvider {
    static var previews: some View {
        DealsBannerView(deals: [Stub.sampleBusiness(), Stub.sampleBusiness()])
    }
}
