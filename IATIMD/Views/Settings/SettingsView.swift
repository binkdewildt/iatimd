//
//  SettingsView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 21/06/2022.
//

import SwiftUI

struct SettingsView: View {
  // MARK: - Properties
  @EnvironmentObject var alertC: AlertController
  
  
  // MARK: - Body
  var body: some View {
    VStack (spacing: 30) {
      
      // MARK: - Account section
      HStack (alignment: .center, spacing: 20) {
        
        // Profile picutre
        ProfilePictureView()
        
        
        VStack (alignment: .leading) {
          Text("\(Authenticate.shared.user?.name ?? "")")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor( Color.primary )
          
          Text("\(Authenticate.shared.user?.email ?? "")")
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.gray)
          
        } //: VSTACK
        
        
      } //: HSTACK
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .strokeBorder(Color.accentColor, lineWidth: 2)
      )
      
      
      
      // Logout
      Button( action: {
        alertC.showAlert(type: .confirm, title: "", text: "Are you sure you want to logout and login again?", image: "", dismissText: "Cancel") {
          withAnimation() {
            Authenticate.shared.logout()
          }
        } dismissAction: {}

      } ) {
        HStack (spacing: 12) {
          
          Image(systemName: "ipad.and.arrow.forward")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
          Text("Logout")
          
          Spacer()
          
        } //: HSTACK
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color("Red"), lineWidth: 2)
        )
        .frame(height: 20)
//        .padding(.horizontal)
      } //: BUTTON
      .foregroundColor(Color.red)
      
      Spacer()
      
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
