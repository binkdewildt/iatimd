//
//  LoginHeaderView.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 20/02/2022.
//

import SwiftUI

struct LoginHeaderView: View {
  // MARK: - Properties
  var title: String
  
  // MARK: - Body
  var body: some View {
    
    // Header
    Text(title)
      .font(.system(size: 55, weight: .bold))
      .foregroundColor(Color.white)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: getRect().height / 4)
      .padding()
    
      // Circles background
      .background(
      
        ZStack {
          
          // Top right circle
          LinearGradient(colors: [
            Color.white,
            Color.white
              .opacity(0.8),
            Color.accentColor
          ], startPoint: .top, endPoint: .bottom)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            .offset(y: -25)
            .ignoresSafeArea()
          
          // Bottom left circle
          Circle()
            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
            .frame(width: 30, height: 30)
            .blur(radius: 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(30)
          
          // Top left circle
          Circle()
            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
            .frame(width: 23, height: 23)
            .blur(radius: 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 30)
          
        } //: ZSTACK
      )
  }
}

// MARK: - Preview
struct LoginHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    
    GeometryReader { geo in
      
      Color.accentColor
      
      // For 1/4 of the screen
      VStack {
        
        LoginHeaderView(title: "Welcome /nback")
      }
    }
    .background( Color.accentColor.ignoresSafeArea() )
  }
}
