//
//  ContentView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  @EnvironmentObject var alertC: AlertController
  @EnvironmentObject var hubC: HubController
  
  
  // MARK: - Body
  var body: some View {
    NavigationView {
      VStack (spacing: 0) {
        
        // Navigation bar
        NavigationBarView()
        
        // Default for devices
        if (hubC.showSettings) {
          SettingsView()
            .transition(.move(edge: .trailing))
        }
        else if (hubC.showLocations && !UIDevice.isIpad) {
          SettingsView()
            .transition(.move(edge: .leading))
        }
        else if (UIDevice.isIphone) { MapView() }
        else if (UIDevice.isIpad) { AllLocationsView() }        
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle("")
      .navigationBarHidden(true)
      
      // If iPad show map on right side
      MapView()
      
    }
    .customAlert(isPresented: alertC.show,
                 CustomPopup(
                  alertType: alertC.alertType,
                  title: alertC.title,
                  image: alertC.image,
                  text: alertC.text,
                  dismissText: alertC.dismissText,
                  isPresented: $alertC.show,
                  action: alertC.action,
                  dismissAction: alertC.dismissAction
                 )
    )
  }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
