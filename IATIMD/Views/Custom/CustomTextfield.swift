//
//  CustomTextfield.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 20/02/2022.
//

import SwiftUI

struct CustomTextfield: View {
  // MARK: - Properties
  var title, icon, placeholder: String
  @Binding var value: String
  @Binding var showPassword: Bool
  var fill: Bool = true
  
  // MARK: - Body
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      
        Label {
          Text(title)
            .font(.system(size: 14))
          
        } icon: {
          Image(systemName: icon)
        }
        .foregroundColor(Color.black.opacity(0.8))
      
      Group {
        if (title.contains("Password") && !showPassword) {
          SecureField(placeholder, text: $value)
            .padding(.top, 2)
        }
        else {
          TextField(placeholder, text: $value)
            .padding(.top, 2)
            .if(title.contains("Email")) { view in
              view.keyboardType(.emailAddress)
            }
        }
      }
      .if(fill) { view in
        view
          .padding(.vertical, 10)
          .padding(.horizontal)
          .background(
            RoundedRectangle(cornerRadius: 10)
             .strokeBorder( Color.accentColor, lineWidth: 2)
          )
      }
      
      if (!fill) {
        Divider()
          .background( Color.black.opacity(0.4) )
      }
      
    } //: VSTACK
  

//    // Show button for password fields
//    .if(title.contains("Password")) { view in
//      view.overlay(
//        Button(action: { showPassword.toggle() }) {
//          Text(showPassword ? "Hide" : "Show")
//            .font(.system(size: 13, weight: .bold))
//            .foregroundColor(Color.accentColor)
//        }
//          .offset(y: 8)
//        , alignment: .trailing)
//    }
  }
}

// MARK: - Preview
struct CustomTextfield_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextfield(title: "Email", icon: "envelope", placeholder: "yourname@gmail.com", value: .constant(""), showPassword: .constant(false))
    
  }
}
