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

final class DirectionsViewModel: ObservableObject {
    private var locationService: LocationService!
    var fromCoordinates: Coordinates?
    var toCoordinates: Coordinates?
    @Published private(set) var routes: (value: [Route]?, error: Error?)
    var directionsCancellable: AnyCancellable?

    func getDirections() {
        directionsCancellable = locationService.getDirections(fromCoordinates: fromCoordinates, toCoordinates: toCoordinates).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.routes = (nil, error)
            case .finished: ()
            }
        }, receiveValue: { value in
            self.routes = (value, nil)
        })
    }

    convenience init(locationService: LocationService = LocationService.defaultService, fromCoordinates: Coordinates? = nil, toCoordinates: Coordinates? = nil) {
        self.init()
        self.locationService = locationService
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
    }
}
