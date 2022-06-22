//
//  RegisterFields.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 16/02/2022.
//

import SwiftUI

struct RegisterFields: View {
  // MARK: - Properties
  @Binding var username: String
  @Binding var email: String
  @Binding var password: String
  @Binding var confirmPassword: String
  
  @Binding var showPassword: Bool
  @Binding var showConfirmPassword: Bool
  
  
  // MARK: - Body
  var body: some View {
    VStack (spacing: 25) {
      
      CustomTextfield(title: "Username", icon: "person", placeholder: "Your username", value: $username, showPassword: .constant(false))
      
      CustomTextfield(title: "Email", icon: "envelope", placeholder: "Your email", value: $email, showPassword: .constant(false))
    
      CustomTextfield(title: "Password", icon: "lock", placeholder: "123456", value: $password, showPassword: $showPassword)
      
      CustomTextfield(title: "Re-Enter Password", icon: "lock", placeholder: "123456", value: $confirmPassword, showPassword: $showConfirmPassword)
      
    } //: VSTACK
    .transition(.move(edge: .trailing))
  }
}

// MARK: - Preview
struct RegisterFields_Previews: PreviewProvider {
  static var previews: some View {
    RegisterFields(username: .constant("Test user"), email: .constant("test@gmail.com"), password: .constant("testpassword"), confirmPassword: .constant("testpassword"), showPassword: .constant(true), showConfirmPassword: .constant(false))
  }
}
