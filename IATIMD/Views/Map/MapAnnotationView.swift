//
//  MapAnnotation.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import SwiftUI

struct MapAnnotationView: View {
  // MARK: - Properties
  @State private var animation: Double = .zero
  
  
  // MARK: - Body
  var body: some View {
    ZStack {
      
      Circle()
        .fill(Color.accentColor)
        .frame(width: 54, height: 54, alignment: .center)
      
      Circle()
        .stroke(Color.accentColor, lineWidth: 2)
        .frame(width: 52, height: 52, alignment: .center)
        .scaleEffect(1 + CGFloat(animation))
        .opacity(1 - animation)
      
    }
    .onAppear() {
      withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
        animation = 1
      }
    }
  }
}


// MARK: - Preview
struct MapAnnotationView_Previews: PreviewProvider {
  static var previews: some View {
    MapAnnotationView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
