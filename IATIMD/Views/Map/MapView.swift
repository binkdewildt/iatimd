//
//  MapView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
  // MARK: - Properties
  @EnvironmentObject var locC: LocationController
  @EnvironmentObject var alertC: AlertController
  
  
  @State private var region: MKCoordinateRegion = MKCoordinateRegion()
  @State var tracking: MapUserTrackingMode = .follow
  @State private var showModal: Bool = true
  
  
  // MARK: - Body
  var body: some View {
    
    ZStack () {
      
      
      Map(coordinateRegion: $locC.region,
          interactionModes: .all,
          showsUserLocation: true,
          userTrackingMode: .none,
          annotationItems: locC.pins
      ) {item in
        MapAnnotation(coordinate: item.location) {
          MapAnnotationView()
        }
      }
      .edgesIgnoringSafeArea(.all)
      .zIndex(0)
      
      
      if (locC.authorized && locC.lastLocation != nil) {
        VStack () {
          Spacer()
          HStack (spacing: 12) {
            
            CurrentLocation()
            
            MapButtonView()
          }
          .padding()
        }
      }
    }
    
    .onAppear() {
      
      // Check if the permissions are denied
      if (locC.locationStatus == .denied) {
        alertC.showAlert(
          type: .error,
          title: "",
          text: "We could not get your location, please go to settings and allow us to get your location.",
          image: "",
          dismissText: "Take me there",
          action: {},
          dismissAction: {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
          })
      }
    }
    .onAppear() {
      
    }
    
    
    //    ZStack (alignment: .center) {
    //
    //      // Current location
    //      VStack {
    //        CurrentLocation()
    //        Spacer()
    //      }
    //      .padding(.horizontal)
    //      .zIndex(1)
    //
    //      // Map
    
    //
    //
    //      // Tracking on / off
    //      VStack (alignment: .trailing, spacing: 0) {
    //        Spacer()
    //        HStack {
    //          Spacer()
    //          Button {
    //            print("Pin my current location")
    //
    //            let result = locC.setLocation()
    //
    //            if (!result) {
    //              alertC.showAlert(
    //                type: .error,
    //                title: "",
    //                text: "We could not get your location, please go to settings and allow us to get your location.",
    //                image: "",
    //                dismissText: "Take me there",
    //                action: {},
    //                dismissAction: {
    //                  UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    //                })
    //            }
    //
    //          } label: {
    //            Image(systemName: "pin")
    //              .resizable()
    //              .scaledToFit()
    //              .frame(width: 50, height: 50)
    //              .foregroundColor(Color.white)
    //              .padding()
    //              .background(
    //                RoundedRectangle(cornerRadius: 8)
    //                  .fill(Color.accentColor)
    //              )
    //          }
    //        }
    //        .padding()
    //      }
    //
    //    }
    //    .onAppear() {
    //
    //
    //      region = {
    //        let mapCoordinates = CLLocationCoordinate2D(
    //          latitude: locC.lastLocation?.coordinate.latitude ?? 0,
    //          longitude: locC.lastLocation?.coordinate.longitude ?? 0)
    //        let mapZoomLevel = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
    //        let mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    //
    //        return mapRegion
    //
    //      }()
    //    }
  }
}

// MARK: - Preview
struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
      .environmentObject(LocationController())
      .environmentObject(AlertController())
  }
}
