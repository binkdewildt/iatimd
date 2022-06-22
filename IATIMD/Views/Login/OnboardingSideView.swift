//
//  OnboardingSideView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 22/06/2022.
//

import SwiftUI

struct OnboardingSideView: View {
  var body: some View {
    Text("Login or create an account on the left side.")
      .foregroundColor(Color.white)
      .fontWeight(.bold)
      .font(.title)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background( Color.accentColor )
  }
}

struct OnboardingSideView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingSideView()
  }
}
