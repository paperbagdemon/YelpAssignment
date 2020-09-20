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
import MapboxGeocoder

class DirectionsViewEvents {
    var bag = Set<AnyCancellable>()
}

struct GeocodedPlacemarkWrapper: Identifiable {
    var id = UUID().uuidString
    var placemark: GeocodedPlacemark?
}

struct DirectionsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: DirectionsViewModel
    var events = DirectionsViewEvents()
    @State var isLocationSelected = false
    var body: some View {
        buildBodyView()
        .onAppear {
            self.viewModel.$startLocationQuery
            .removeDuplicates()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { (val) in
                if !val.isEmpty, val.count > 3, self.isLocationSelected == false {
                    self.viewModel.getLocations(term: self.viewModel.startLocationQuery)
                }
            }
            .store(in: &self.events.bag)
            self.viewModel.getDirections()
        }
        .accessibility(identifier: "directionsView")
    }

    init(viewModel: DirectionsViewModel){
        print("directions")
        self.viewModel = viewModel
    }

    func buildAutoSuggestList() -> AnyView {
        let locationList: [GeocodedPlacemarkWrapper]? = self.viewModel.locations.value?.map({ value -> GeocodedPlacemarkWrapper in
            return GeocodedPlacemarkWrapper.init(placemark: value)
        })
        if let locations = locationList, isLocationSelected == false {
            return AnyView(
                VStack {
                    ForEach(locations) { value in
                        VStack(spacing: 0) {
                            HStack {
                                Button(action: {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    self.isLocationSelected = true
                                    self.viewModel.fromCoordinates = Coordinates.init(latitude: value.placemark?.location?.coordinate.latitude, longitude: value.placemark?.location?.coordinate.longitude)
                                    self.viewModel.startLocationQuery = value.placemark?.qualifiedName ?? ""
                                    self.viewModel.getDirections()
                                }, label: {
                                    Text(value.placemark?.qualifiedName ?? "")
                                    .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                                })
                                .padding(EdgeInsets.init(top: 0, leading: 35, bottom: 0, trailing: 0))
                                Spacer()
                            }
                            Divider()
                        }
                        .background(Color(.secondarySystemBackground))
                    }
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }

    func buildBodyView() -> AnyView {
        return AnyView(
            ZStack {
                MapboxView(fromCoordinates: viewModel.fromCoordinates, toCoordinates: viewModel.toCoordinates, route: self.viewModel.routes.value?.first)
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
                        TextField("starting from current location", text: Binding.init(get: {
                            self.viewModel.startLocationQuery
                        }, set: { value in
                            self.viewModel.startLocationQuery = value
                        }), onEditingChanged: { _ in
                            self.isLocationSelected = false
                        }, onCommit: {
                            self.viewModel.locations = (nil, nil)
                            self.viewModel.getDirections()
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.viewModel.startLocationQuery = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").opacity(self.viewModel.startLocationQuery == "" ? 0 : 1)
                        })
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(3.0)
                    buildAutoSuggestList()
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
