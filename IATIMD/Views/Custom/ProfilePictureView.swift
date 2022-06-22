//
//  ProfilePictureView.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 22/02/2022.
//

import SwiftUI

struct ProfilePictureView: View {
  // MARK: - Properties
  var image: String?
  var borderColor: Color = .accentColor
  var borderSize: CGFloat = 2.5
  
  // MARK: - Body
  var body: some View {
    GeometryReader { geo in
      ZStack {
        
        Circle()
          .fill( borderColor )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        ZStack (alignment: .bottom) {
          Circle()
            .fill( Color.gray )
          
          Image(systemName: image ?? "person.fill")
            .resizable()
            .scaledToFit()
            .frame(height: geo.size.height * 0.75)
            .foregroundColor(Color.white)
        } //: ZSTACK
        .frame(maxWidth: geo.size.width - 2 * borderSize, maxHeight: geo.size.height - 2 * borderSize)
        .clipShape(Circle())
        
      } //: ZSTACK
    } //: GEO READER
    .frame(width: 50, height: 50)
  }
}

struct ProfilePictureView_Previews: PreviewProvider {
  static var previews: some View {
    ProfilePictureView()
  }
}
