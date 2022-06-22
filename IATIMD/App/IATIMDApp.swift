//
//  IATIMDApp.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import SwiftUI

@main
struct IATIMDApp: App {
  // MARK: - Properties
  @StateObject var alertC: AlertController = AlertController()
  @StateObject var locC: LocationController = LocationController()
  @ObservedObject var authC: Authenticate = Authenticate.shared
  @StateObject var hubC: HubController = HubController()
  
  // MARK: - Body
  var body: some Scene {
    WindowGroup {
      
      if (!authC.isValidated) {
        AuthView()
      }
      else {
        ContentView()
          .environmentObject(alertC)
          .environmentObject(locC)
          .environmentObject(hubC)
      }
    }
  }
}
