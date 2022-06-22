//
//  CustomButton.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import SwiftUI

import SwiftUI

// MARK: - Enum Button Types
enum ButtonTypes {
  case primary, secondary, tertiary, error, errorSecondary
  
  // MARK: - Properties
  var fill: Bool {
    switch self {
    case .primary, .error:
      return true
      
    default:
      return false
    }
  }
  
  var backColor: Color {
    switch self {
    case .primary, .secondary:
      return Color.accentColor
    case .tertiary:
      return Color.primary
    case .error, .errorSecondary:
      return Color("Red")
    }
  }
  
  var textColor: Color {
    switch self {
    case .primary, .error:
      return Color.white
    case .secondary:
      return Color.accentColor
    case .tertiary:
      return Color.primary
    case .errorSecondary:
      return Color("Red")
    }
  }
}


// MARK: - Custom Button View
struct CustomButton: View {
  // MARK: - Properties
  var buttonType: ButtonTypes
  var text: String
  var image: String?
  var systemImage: Bool = false
  var height: CGFloat = 40
  var width: CGFloat = 220
  var action: () -> Void
  
  // MARK: - Body
  var body: some View {
    Button(action: { self.action() }) {
      
      // Button with image
      if let imageName = image {
        
        HStack (spacing: 10){
          Image(systemName: imageName)
            .font(.system(size: 20, weight: .semibold))
            .frame(width: 30, height: 30)
        
          Text(text)
            .lineLimit(1)
          
        } //: HSTACK
        .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .leading)
        .padding(.leading, 20)
        
      } else {
        
        Text(text)
          .lineLimit(1)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        
      }
    } //: BUTTON
    .frame(width: width, height: height)
    .font(.system(size: 18, weight: .semibold))
    .if (buttonType.fill) { view in
      view.background( buttonType.backColor )
    }
    .if (!buttonType.fill) { view in
      view.background(
            RoundedRectangle(cornerRadius: 10)
              .strokeBorder( buttonType.backColor, lineWidth: 2)
            )
    }
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
    .foregroundColor( buttonType.textColor )
  }
}

// MARK: - Preview
struct CustomButtonView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      
      // Primary
      CustomButton(buttonType: .primary, text: "Login with FaceID", action: {})
      CustomButton(buttonType: .primary, text: "Login with FaceID", image: "faceid", action: {})
      
      
      // Secondary
      CustomButton(buttonType: .secondary, text: "Login with FaceID", action: {})
      CustomButton(buttonType: .secondary, text: "Login with FaceID", image: "faceid", action: {})
      
      // Tertiary
      CustomButton(buttonType: .tertiary, text: "Login with FaceID", action: {})
      CustomButton(buttonType: .tertiary, text: "Login with FaceID", image: "faceid", action: {})
      
      // Tertiary
      CustomButton(buttonType: .error, text: "Login with FaceID", action: {})
      CustomButton(buttonType: .error, text: "Login with FaceID", image: "faceid", action: {})
      
      // Tertiary
      CustomButton(buttonType: .errorSecondary, text: "Login with FaceID", action: {})
      CustomButton(buttonType: .errorSecondary, text: "Login with FaceID", image: "faceid", action: {})
      
    }
.previewInterfaceOrientation(.landscapeLeft) //: VSTACK
  }
}
