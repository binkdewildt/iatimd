//
//  AuthView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 20/06/2022.
//

import SwiftUI

struct AuthView: View {
  
  // MARK: - Properties
  @ObservedObject private var authC: Authenticate = Authenticate.shared
  @State private var showLoginPage: Bool = false
  //  @State private var showRegisterPage: Bool = false
  var buttonHeight: CGFloat = 55
  var buttonWidth: CGFloat = 250
  
  // MARK: - Body
  var body: some View {
    NavigationView {
      VStack (spacing: 0) {
        
        LoginHeaderView(title: "Welcome\n")
        
        BottomOverlayView(title: "Choose an option") {
          
          Spacer()
          
          // Email
          CustomButton(buttonType: .primary, text: "Login with email", image: "envelope.fill", height: buttonHeight, width: buttonWidth) {
            withAnimation() { showLoginPage = true }
          }
          
          // OR
          CustomDevider(text: "OR", color: .black)
          
          // Register
          CustomButton(buttonType: .tertiary, text: "Create an account", image: "list.bullet.rectangle.portrait", height: buttonHeight, width: buttonWidth) {
            authC.isRegistering = true
            withAnimation() { showLoginPage = true }
          }
          
          Spacer()
          
        }
        .frame(maxHeight: .infinity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background( Color.accentColor.ignoresSafeArea() )
      
      // Navigate to loginView
      .overlay(
        Group {
          if (showLoginPage) {
            AuthHandlerView()
              .transition(.move(edge: .trailing))
          }
        } //: GROUP
      )
      .navigationBarHidden(true)
      
      OnboardingSideView()
      
      
      
    } //: NAVIGATION VIEW
    
  }
}

struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView()
  }
}
