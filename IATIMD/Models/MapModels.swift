//
//  MapModels.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import Foundation
import CoreLocation

struct MapLocation: Codable, Identifiable {
  let id: String
  let name: String
  let latitude: Double
  let longitude: Double
  
  // Computed properties
  var location: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

struct LocationResponse: Codable, Identifiable {
  let id: String
  let userID: String
  let name: String
  let latitude: String
  let longitude: String
}

