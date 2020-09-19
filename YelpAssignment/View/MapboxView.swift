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
    private var mapView: MGLMapView = MGLMapView(frame: .zero,
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
            view.addAnnotation(routeLine)
//            let camera = mapView.cameraThatFitsShape(routeLine, direction: 0, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
//            view.setCamera(camera, animated: true)
            let centerCoordinates = routeCoordinates[Int(routeCoordinates.count/2)]
            view.setCenter(centerCoordinates, zoomLevel: 13, animated: true)
        } else {
            view.setCenter(CLLocationCoordinate2D(latitude: fromCoordinates?.latitude ?? 0.1, longitude: fromCoordinates?.longitude ?? 0.1), zoomLevel: 13, animated: false)
        }
    }

    init(fromCoordinates: Coordinates? = nil, toCoordinates: Coordinates? = nil, route: Route? = nil) {
        self.fromCoordinates = fromCoordinates
        self.toCoordinates = toCoordinates
        self.route = route
    }
}

struct MapboxView_Previews: PreviewProvider {
    static var previews: some View {
        MapboxView(fromCoordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512))
    }
}
