//
//  RoundedCorners.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 13/02/2022.
//

import SwiftUI

struct RoundedCorners: Shape {
  // MARK: - Properties
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
