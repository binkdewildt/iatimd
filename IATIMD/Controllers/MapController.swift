//
//  MapController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import Foundation
import MapKit
import CoreLocation



public class MapController: ObservableObject {
  
  @Published var region: MKCoordinateRegion = {
    var mapCoordinates = CLLocationCoordinate2D(latitude: 37, longitude: -122)
    var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
    var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    
    return mapRegion
  }()
  
  let mapLocations: [MapLocation] = []
      
  
}
