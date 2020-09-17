//
//  HoursView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct HoursView: View {
    var hours: [Hour]?
    @State var isDisplayingHours: Bool = false
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if isDisplayingHours {
            if let hours = self.hours {
                return AnyView(
                    Button(action: {
                        self.isDisplayingHours.toggle()
                    }, label: {
                        VStack {
                            ForEach(0..<hours.count) { index in
                                Text(self.hours![index].displayText())
                                    .font(.system(size: 12))
                            }
                        }
                    })
                )
            } else {
                return AnyView(
                    Button(action: {
                        self.isDisplayingHours.toggle()
                    }, label: {
                        Text("No hours available")
                    })
                )
            }
        } else {
            return AnyView(
                Button(action: {
                    self.isDisplayingHours.toggle()
                }, label: {
                    VStack {
                        Text(hours?.first?.isOpenNow ?? true ? "Now Open" : "Closed")
                        .font(.system(size: 14))
                        .bold()
                        Text("(View Hours)")
                        .font(Font.system(size: 14))
                    }
                })
            )
        }
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView(hours: [Hour.init(hoursType: "Regular",
                                    open: [Open.init(isOvernight: true, start: "1000", end: "2100", day: 0),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 1),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 2),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 3),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 4),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 5)], isOpenNow: true)])
    }
}
