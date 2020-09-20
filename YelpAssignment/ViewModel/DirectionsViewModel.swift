//
//  DirectionsViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/19/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Combine
import MapboxDirections
import MapboxGeocoder
import Mapbox

final class DirectionsViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    private var locationService: LocationService!
    var fromCoordinates: Coordinates?
    var toCoordinates: Coordinates?
    @Published var startLocationQuery: String = ""
    @Published var routes: (value: [Route]?, error: Error?)
    @Published var locations: (value: [GeocodedPlacemark]?, error: Error?)

    func getDirections() {
        locationService.getDirections(fromCoordinates: fromCoordinates, toCoordinates: toCoordinates).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.routes = (nil, error)
                self.objectWillChange.send()
            case .finished: ()
            }
        }, receiveValue: { value in
            self.routes = (value, nil)
            self.objectWillChange.send()
        })
        .store(in: &bag)
    }

    func getLocations(term: String) {
        locationService.getLocations(term: term).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.locations = (nil, error)
            case .finished: ()
            }

        }, receiveValue: { value in
            self.locations = (value, nil)
            self.objectWillChange.send()
        })
        .store(in: &bag)
    }

    convenience init(locationService: LocationService = LocationService.defaultService, fromCoordinates: Coordinates? = nil, toCoordinates: Coordinates? = nil) {
        self.init()
        self.locationService = locationService
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
    }
}
