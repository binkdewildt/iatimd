//
//  BottomOverlayView.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 20/02/2022.
//

import SwiftUI

struct BottomOverlayView <Content: View> : View {
  // MARK: - Properties
  var title: String
  @ViewBuilder var content: Content

  
  // MARK: - Body
  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical, showsIndicators: false) {
        VStack (spacing: 15) {
          
          HStack {
            Text(title)
              .font(.system(size: 22, weight: .bold))
          } //: HSTACK
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.bottom, 30)

          
          content
          
        } //: VSTACK
        .padding(30)
        .padding(.bottom, 10)
        .frame(minHeight: geo.size.height)
        
      } //: SCROLLVIEW
      .frame(maxWidth: .infinity)
      
  //    .frame(height: getRect().height / 4 * 3)   // Max height 3/4th of the screen
      .background(
        Color.white
          .cornerRadius(30, corners: [.topLeft, .topRight])
          .edgesIgnoringSafeArea(.bottom)
      )
      .transition(.move(edge: .bottom))
    } //: GEO READER
    
    .onTapGesture {
      UIApplication.shared.endTextfieldEditing()
    }
  }
}

// MARK: - Preview
struct BottomOverlayView_Previews: PreviewProvider {
  static var previews: some View {
    
    VStack {
      Spacer()
      
      BottomOverlayView(title: "Test title") {
        Text("Hello world")
        
        Spacer()
        
        Text("Bottom align text")
      }
    } //: VSTACK
    .background(Color.accentColor.ignoresSafeArea())
.previewInterfaceOrientation(.landscapeLeft)
  }
}
