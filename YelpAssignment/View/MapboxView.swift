//
//  DirectionsView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/19/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import Mapbox
import MapboxDirections

struct MapboxView: UIViewRepresentable {
    var fromCoordinates: Coordinates?
    var toCoordinates: Coordinates?
    var destinationName: String
    var fromName: String

    private(set) var mapView: MGLMapView = MGLMapView(frame: .zero,
                                                 styleURL: URL(string: "mapbox://styles/mapbox/streets-v11") )
    var route: Route?
    func makeUIView(context: Context) -> MGLMapView {
        return mapView
    }

    func updateUIView(_ view: MGLMapView, context: Context) {
        view.showsUserLocation = true
        if var routeCoordinates = route?.shape?.coordinates, routeCoordinates.count > 0 {
            // Convert the route’s coordinates into a polyline.
            let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))

            let fromPoint = MGLPointAnnotation()
            fromPoint.coordinate = CLLocationCoordinate2DMake(fromCoordinates?.latitude ?? 0, fromCoordinates?.longitude ?? 0)
            fromPoint.title = destinationName

            let toPoint = MGLPointAnnotation()
            toPoint.coordinate = CLLocationCoordinate2DMake(toCoordinates?.latitude ?? 0, toCoordinates?.longitude ?? 0)
            toPoint.title = fromName

            view.removeAnnotations(view.annotations ?? [])
            view.addAnnotation(routeLine)
            view.addAnnotation(fromPoint)
            view.addAnnotation(toPoint)
            let centerCoordinates = routeCoordinates[Int(routeCoordinates.count/2)]
            view.setCenter(centerCoordinates, zoomLevel: 13, animated: true)
        } else {
            view.setCenter(CLLocationCoordinate2D(latitude: toCoordinates?.latitude ?? 0.1, longitude: toCoordinates?.longitude ?? 0.1), zoomLevel: 13, animated: false)
        }
    }

    init(fromCoordinates: Coordinates? = nil, toCoordinates: Coordinates? = nil, route: Route? = nil, destinationName: String = "Business Location", fromName: String = "You Start Here", delegate: MGLMapViewDelegate? = nil) {
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
        self.route = route
        self.destinationName = destinationName
        self.fromName = fromName
        mapView.delegate = delegate
    }
}

struct MapboxView_Previews: PreviewProvider {
    static var previews: some View {
        MapboxView(fromCoordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512))
    }
}
