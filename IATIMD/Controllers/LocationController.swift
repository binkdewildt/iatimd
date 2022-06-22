//
//  LocationController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import Foundation
import CoreLocation
import MapKit

class LocationController: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  private let locationManager = CLLocationManager()
  @Published var locationStatus: CLAuthorizationStatus?
  @Published var lastLocation: CLLocation?
  @Published var tracking: Bool = false
  @Published var region: MKCoordinateRegion = {
    let mapCoordinates = CLLocationCoordinate2D(
      latitude: 0,
      longitude: 0
    )
    let mapZoomLevel = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    let mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    
    return mapRegion
  }()
  
  // Pins
  @Published var pins: [MapLocation] = []
  
  var authorized: Bool  {
    return locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse
  }
  
  
  // MARK: - Init
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    tracking = true
    locationStatus = locationManager.authorizationStatus
    
    fetchPins()
  }
  
  
  // MARK: - Methods
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    
    if manager.authorizationStatus == .authorizedWhenInUse{
      manager.startUpdatingLocation()
    } else {
      manager.requestWhenInUseAuthorization()
    }
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
    if (lastLocation == nil) {
      setRegion(lat: location.coordinate.latitude, long: location.coordinate.longitude)
    }
    
    lastLocation = location
  }
  
  func setRegion(lat: Double, long: Double) {
    region = {
      let mapCoordinates = CLLocationCoordinate2D(
        latitude: lat,
        longitude: long
      )
      let mapZoomLevel = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
      let mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
      
      return mapRegion
    }()
  }
  
  func saveLocation(name: String, latitude: Double? = nil, longitude: Double? = nil) {
    let new = MapLocation(
      id: UUID().uuidString,
      name: name,
      latitude: latitude ?? self.lastLocation!.coordinate.latitude,
      longitude: longitude ?? self.lastLocation!.coordinate.longitude
    )
    
    if (self.lastLocation != nil || (latitude != nil && longitude != nil)) {
      pins.append(new)
      
      storePins()
      
      // Update the server
      postPin(body: new)
    }
  }
  
  func getPins() -> [MapLocation] {
    if let objects = UserDefaults.standard.value(forKey: "locations") as? Data {
      let decoder = JSONDecoder()
      if let array = try? decoder.decode(Array.self, from: objects) as [MapLocation] {
        return array
      }
    }
    return []
  }
  
  func storePins() {
    // Save all the pins to user defaults
    if let encoded = try? JSONEncoder().encode(self.pins) {
      UserDefaults.standard.set(encoded, forKey: "locations")
    }
  }
  
  func deletePin(id: String) {

    if let index = pins.firstIndex(where: {$0.id == id}) {
      pins.remove(at: index)
    }
    
    storePins()
    
    // Send to the server
    Network.shared.deletePin(id) { (_) in }
  }
  
  func fetchPins() {
    Network.shared.getAllPins { (result) in
      switch (result) {
      case .success(let data):
        
        for loc in data {
          self.pins.append(
            MapLocation(
              id: loc.id,
              name: loc.name,
              latitude: Double(loc.latitude)!,
              longitude: Double(loc.longitude)!
            )
          )
        }

      case .failure(let error):
        self.pins = self.getPins()
        print(error)
      }
    }
  }
  
  func postPin(body: MapLocation) {
    Network.shared.postPin(body) { (_) in }
  }
}
