//
//  AllLocationsView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 21/06/2022.
//

import SwiftUI

struct AllLocationsView: View {
  // MARK: - Properties
  @EnvironmentObject var locC: LocationController
  
  // MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack (spacing: 12) {
        
        if (locC.pins.isEmpty) {
            Text("You don't have any saved locations, add one first")
            .multilineTextAlignment(.center)
        }
        
        ForEach(locC.pins) { pin in
          
          LocationView(location: pin)
          
          if (pin.id != locC.pins.last?.id ?? "") {
            CustomDevider(color: Color.accentColor)
          }
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

struct AllLocationsView_Previews: PreviewProvider {
  static var previews: some View {
    AllLocationsView()
  }
}
