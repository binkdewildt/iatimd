//
//  LocationView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 21/06/2022.
//

import SwiftUI

struct LocationView: View {
  // MARK: - Properties
  @EnvironmentObject var locC: LocationController
  @EnvironmentObject var hubC: HubController
  var location: MapLocation
  
  // MARK: - Body
  var body: some View {
    HStack {
      Button(action: {
        withAnimation() {
          hubC.showLocations = false
          locC.setRegion(
            lat: location.latitude,
            long: location.longitude
          )
        }
      }) {
        VStack (alignment: .leading, spacing: 5) {
          Text("\(location.name)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.accentColor)
          
          
          VStack (alignment: .leading, spacing: 4) {
            Text("Latitude: \(location.latitude)")
              .font(.footnote)
            
            Text("Longitude: \(location.longitude)")
              .font(.footnote)
          }
          .foregroundColor(Color.gray)
        }
        
        
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
      
      Button(action: {
        locC.deletePin(id: location.id)
      }) {
        Image(systemName: "trash")
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(Color("Red"))
      }
    }
  }
}


// MARK: - Preview
struct LocationView_Previews: PreviewProvider {
  static var previews: some View {
    LocationView(
      location: MapLocation(id: UUID().uuidString,
                            name: "Test location",
                            latitude: 0.0,
                            longitude: 0.0
                           )
    )
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
