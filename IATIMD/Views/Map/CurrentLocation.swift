//
//  CurrentLocation.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import SwiftUI

struct CurrentLocation: View {
  // MARK: - Properties
  @EnvironmentObject var locC: LocationController
  
  
  // MARK: - Body
  var body: some View {
    HStack (alignment: .center, spacing: 12) {
      Image("Compass")
        .resizable()
        .scaledToFit()
        .frame(width: 48, height: 48, alignment: .center)
      
      VStack (alignment: .leading, spacing: 3) {
        HStack {
          Text("Latitude: \(locC.lastLocation?.coordinate.latitude ?? 0)")
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(Color.accentColor)
          
          Spacer()
          
          Text("")
            .font(.footnote)
            .foregroundColor(Color.white)
        } //: HSTACK
        
        Divider()
        
        HStack {
          Text("Longitude: \(locC.lastLocation?.coordinate.longitude ?? 0)")
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(Color.accentColor)
          
          Spacer()
          
          Text("")
            .font(.footnote)
            .foregroundColor(Color.white)
        } //: HSTACK
      } //: VSTACK
    } //: HSTACK
    .padding(.vertical, 12)
    .padding(.horizontal, 16)
    .background(
      Color.black
        .cornerRadius(8)
        .opacity(0.6)
    )
    .frame(height: 35)
  }
}

// MARK: - Preview
struct CurrentLocation_Previews: PreviewProvider {
  static var previews: some View {
    CurrentLocation()
      .environmentObject(LocationController())
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
