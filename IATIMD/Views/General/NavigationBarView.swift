//
//  NavigationBarView.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 12/01/2022.
//

import SwiftUI

struct NavigationBarView: View {
  // MARK: - Properties
  @EnvironmentObject var hubC: HubController
  
  
  // MARK: - Body
  var body: some View {
    HStack {
      
      if (!hubC.showSettings && !hubC.showLocations) {
        
        if (!UIDevice.isIpad) {
          Button(action: {
            withAnimation() {
              hubC.showLocations = true
            }
          }) {
            Image("Pin")
              .resizable()
              .scaledToFit()
              .frame(width: 25, height: 25)
          }
        }
        
        Spacer()
        
        Button(action: {
          withAnimation() {
            hubC.showSettings = true
          }
        }) {
          Image(systemName: "gear")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
        }
      } else {
        
        Button(action: {
          withAnimation() {
            hubC.showSettings = false
            hubC.showLocations = false
          }
        }) {
        Image(systemName: "chevron.left")
          .resizable()
          .scaledToFit()
          .frame(width: 25, height: 25)
        }
        
        Spacer()
      }
      
    } //: HSTACK
    .foregroundColor(Color.white)
    .padding(.horizontal)
    .padding(.bottom)
    .padding(.top, 4)
    .background(
      Color.accentColor.shadow(radius: 3)
        .edgesIgnoringSafeArea(.top)
        .shadow(color: .black, radius: 5, x: 0, y: 5)
    )
  }
}

// MARK: - Preview
struct NavigationBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      NavigationBarView()
      Spacer()
    }
  }
}
