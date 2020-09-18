//
//  MapView.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  var coordinate: Coordinates

  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(self.coordinate.latitude ?? 0, self.coordinate.longitude ?? 0), span: span)

    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2DMake(self.coordinate.latitude ?? 0, self.coordinate.longitude ?? 0)
    view.addAnnotation(annotation)

    view.setRegion(region, animated: true)
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(coordinate: Coordinates.init(latitude: 14.675525, longitude: 121.0437512))
  }
}
