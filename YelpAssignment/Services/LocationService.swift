//
//  LocationService.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/18/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import CoreLocation
import Mapbox
import MapboxDirections
import MapboxGeocoder
import Combine

struct LocationError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        get {
            return self.message
        }
    }
}

class LocationService: NSObject, CLLocationManagerDelegate {
    static let defaultService = LocationService()
    let locationManager = CLLocationManager()
    let geoCoder = Geocoder.shared
    let directions = Directions.shared
    
    @Published var coordinates: Coordinates?
    func startService() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func stopService() {
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        coordinates = Coordinates(latitude: location.latitude, longitude: location.longitude)
    }
    
    //future value is [Route]?, issue with running the the data type on tests
    func getDirections(fromCoordinates: Coordinates?, toCoordinates: Coordinates?) -> Future<[Route]?, Error> {
        let future = Future<[Route]?, Error> { promise in
            if let from = fromCoordinates,let to = toCoordinates, let fromLat = from.latitude, let fromLong = from.longitude, let toLat = to.latitude, let toLong = to.longitude {
                
                let waypoints = [
                    Waypoint(coordinate: CLLocationCoordinate2D(latitude: fromLat, longitude: fromLong), name: "start"),
                    Waypoint(coordinate: CLLocationCoordinate2D(latitude: toLat, longitude: toLong), name: "destination"),
                ]

                let options = RouteOptions(waypoints: waypoints, profileIdentifier: .automobileAvoidingTraffic)
                options.includesSteps = true

                self.directions.calculate(options) { (session, result) in
                    switch result {
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let response):
                        promise(.success(response.routes))
                    }
                }
            } else {
                promise(.failure(LocationError("invalid locations")))
            }
        }
        
        return future
    }
    
    //future value is [GeocodedPlacemark]?, issue with running the the data type on tests
    func getLocations(term: String) -> Future<[GeocodedPlacemark]?, Error> {
        let future = Future<[GeocodedPlacemark]?, Error> { promise in
            let options = ForwardGeocodeOptions(query: term)
            options.allowedScopes = [.address, .pointOfInterest]
            options.maximumResultCount = 7
            _ = self.geoCoder.geocode(options) { (placemarks, attribution, error) in
                if error != nil {
                    promise(.failure(LocationError(error?.localizedDescription ?? "Unable to find locations")))
                } else {
                    promise(.success(placemarks))
                }
            }
        }
        return future
    }
}
