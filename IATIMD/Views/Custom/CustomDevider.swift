//
//  CustomDevider.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 20/02/2022.
//

import SwiftUI

struct CustomDevider: View {
  // MARK: - Properties
  var text: String?
  var color: Color = Color.gray
  var height: CGFloat = 2
  
  
  // MARK: - Body
  var body: some View {
    
    Group {
      // If text is set
      if let text = text {
        ZStack {
          customDeviderView(color: color)
          
          Text(text)
            .foregroundColor(color)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 17)
            .background( Color.white )
          
        } //: HSTACK
      }
      
      else {
        customDeviderView(color: color)
      }
    }
    .frame(maxWidth: 330)
    
  }
  
  @ViewBuilder
  func customDeviderView(color: Color) -> some View {
    RoundedRectangle(cornerRadius: 2)
      .fill(color)
      .frame(maxWidth: .infinity, maxHeight: height)
  }
}

// MARK: - Preview
struct CustomDevider_Previews: PreviewProvider {
  static var previews: some View {
    VStack (spacing: 20) {
      
      
      Spacer()
      
      // With text
      CustomDevider(text: "2 unread messages", color: .black)
      
      CustomDevider(text: "New", color: .black)
      
      Spacer()
      
      // Without text
      CustomDevider(color: .accentColor)
      
      Spacer()
      
    } //: VSTACK
  }
}
