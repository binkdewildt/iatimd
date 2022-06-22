//
//  AuthHandlerView.swift
//  IATIMD
//
//  Created by Bink de Wildt on 20/06/2022.
//

import SwiftUI

struct AuthHandlerView: View {
  // MARK: - Properties
  @ObservedObject private var authC: Authenticate = Authenticate.shared
  
  @State private var username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  @State private var showPassword: Bool = false
  @State private var showConfirmPassword: Bool = false
  
  
  // MARK: - Functions
  func toggleRegister() {
    
    // Clear the fields
    username = ""
    email = ""
    password = ""
    confirmPassword = ""
    showPassword = false
    showConfirmPassword = false
    
    // Togle the registering
    withAnimation() {
      authC.isRegistering.toggle()
    }
  }
  
  // MARK: - Body
  var body: some View {
    VStack(spacing: 0) {
      
      // Header
      LoginHeaderView(title: !authC.isRegistering ? "Welcome\nback" : "Register\nnow")
      
      BottomOverlayView(title: !authC.isRegistering ? "Login with email" : "Create an account") {
        
        if (!authC.isRegistering) { LoginFields(email: $email, password: $password, showPassword: $showPassword) }
        else { RegisterFields(username: $username, email: $email, password: $password, confirmPassword: $confirmPassword, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword) }
        
        HStack (spacing: 8) {
          
          // Forgot password
          Spacer()

          // Stay loggedIn
          Button( action: { authC.stayLoggedIn.toggle() } ) {
            Text("Stay logged in?")

            Image(systemName: authC.stayLoggedIn ? "checkmark.square.fill" : "square")
              .resizable()
              .scaledToFit()
              .frame(width: 15, height: 15)
          }
          .font(.system(size: 12, weight: .bold))
          
        } //: HSTACK
        .frame(maxWidth: .infinity, alignment: .trailing)
        
        Spacer()
        
        
        // Error text
        if let error = authC.error {
          Text(error.localizedDescription)
            .multilineTextAlignment(.center)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color("Red"))
            .padding(.top, 25)
        }
        

        // Button
        CustomButton(buttonType: .primary, text: !authC.isRegistering ? "Login" : "Register") {
          UIApplication.shared.endTextfieldEditing()
          if (!authC.isRegistering) { authC.login(email: email, password: password) }
          else if (authC.isRegistering) { authC.register(username: username, email: email, password: password, confirmPassword: confirmPassword) }
        }
        
        
        // Toggle register
        Button(action: { toggleRegister() }) {
          Text(!authC.isRegistering ? "No account? " : "Already an account? ")
            .font(.system(size: 14))
            .foregroundColor(Color.black) +

          Text(!authC.isRegistering ? "Register now" : "Login now")
            .font(.system(size: 14, weight: .heavy))
            .foregroundColor(Color.accentColor)
        }
      }
      .frame(maxWidth: .infinity)
      
    }
    .background( Color.accentColor.ignoresSafeArea() )
    .onTapGesture {
      UIApplication.shared.endTextfieldEditing()
    }
  }
}


// MARK: - Preview
struct AuthHandlerView_Previews: PreviewProvider {
  static var previews: some View {
    AuthHandlerView()
  }
}
