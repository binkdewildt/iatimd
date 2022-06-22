//
//  MapButtonView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 21/06/2022.
//

import SwiftUI

struct MapButtonView: View {
  // MARK: - Properties
  @EnvironmentObject var locC: LocationController
  
  
  // MARK: - Body
  var body: some View {
    Button(action: {
      alertTF(
        title: "Naam",
        message: "Voer een naam in voor de locatie om hem op te slaan",
        hintText: "Vul hier de naam in",
        primarytitle: "Opslaan",
        secondaryTitle: "Annuleer",
        primaryAction: {text in
          locC.saveLocation(name: text)
        },
        secondaryAction: {})
    }) {
      Image("Pin")
        .resizable()
        .scaledToFit()
        .frame(width: 35, height: 35)
        .foregroundColor(Color.white)
        .overlay(alignment: .bottomTrailing) {
          Image(systemName: "plus.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 10, height: 10)
            .foregroundColor(Color.white)
        }
        .padding()
        .background(
          Color.accentColor
            .cornerRadius(8)
        )
    }
  }
}

// MARK: - Preview
struct MapButtonView_Previews: PreviewProvider {
  static var previews: some View {
    MapButtonView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
