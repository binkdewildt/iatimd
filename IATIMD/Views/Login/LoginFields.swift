//
//  LoginFields.swift
//  IATIMD
//
//  Created by Bink de Wildt on 20/06/2022.
//

import SwiftUI

struct LoginFields: View {
  // MARK: - Properties
  @Binding var email: String
  @Binding var password: String
  @Binding var showPassword: Bool
  
  
  // MARK: - Body
  var body: some View {
    VStack (spacing: 25) {
      
      CustomTextfield(title: "Email", icon: "envelope",  placeholder: "yourname@gmail.com", value: $email, showPassword: .constant(false))
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
      
      
      CustomTextfield(title: "Password", icon: "lock", placeholder: "123456", value: $password, showPassword: $showPassword)
      
    } //: VSTACK
    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
  }
}


// MARK: - Preview
struct LoginFields_Previews: PreviewProvider {
  static var previews: some View {
    LoginFields(email: .constant("test@gmail.com"), password: .constant("testpassword"), showPassword: .constant(true))
  }
}
