//
//  PhoneNumbersView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI

struct PhoneNumbersView: View {
    var phoneNumber: String?
    var body: some View {
        buildBodyView()
    }
    func buildBodyView() -> AnyView {
        if let number = phoneNumber {
            if !number.isEmpty {
                return AnyView(
                    HStack {
                        Button(action: {
                            print("call")
                        }, label: {
                            Image(systemName: "phone")
                        })
                        Text(number)
                            .font(.system(size: 14))
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

struct PhoneNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumbersView(phoneNumber: "09662042")
    }
}
