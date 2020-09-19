//
//  DirectionsView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/19/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import MapboxDirections
import Combine

class DirectionsViewEvents {
    var cancellable: AnyCancellable?
}

struct DirectionsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var startText = ""
    @ObservedObject var viewModel: DirectionsViewModel
    @State var route: Route?
    var events = DirectionsViewEvents()

    var body: some View {
        buildBodyView()
        .onAppear {
            self.events.cancellable = self.viewModel.$routes.sink { value in
                self.route = value.value?.first
            }
            self.viewModel.getDirections()
        }
    }

    func buildBodyView() -> AnyView {
        return AnyView(
            ZStack {
                MapboxView(fromCoordinates: viewModel.fromCoordinates, toCoordinates: viewModel.toCoordinates, route: self.route)
                VStack {
                    Text("Get directions")
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 1, y: 1)
                    .padding()
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
                            .foregroundColor(Color.blue)
                            .frame(width: 20, height: 20)
                            .padding()
                        })
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Image(systemName: "scribble")

                        TextField("starting from current location", text: $startText, onEditingChanged: { _ in
                            print("")
                        }, onCommit: {
                            print("")
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.startText = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").opacity(startText == "" ? 0 : 1)
                        })
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(3.0)
                    Spacer()
                }
            }
        )
    }
}

struct DirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsView(viewModel: DirectionsViewModel(
            fromCoordinates: Coordinates(latitude: 14.675525, longitude: 121.0437512),
            toCoordinates: Coordinates(latitude: 14.6032416, longitude: 121.0045141)))
    }
}
