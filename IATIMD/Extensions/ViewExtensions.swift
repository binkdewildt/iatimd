//
//  ViewExtensions.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation
import SwiftUI

extension View {
  
  // MARK: - Custom Corners Modifier
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape( RoundedCorners(radius: radius, corners: corners) )
  } //: cornerRadius
  
  // MARK: - Get the dimensions
  func getRect() -> CGRect {
    return UIScreen.main.bounds
  } //: getRect
  
  
  // MARK: - Custom alert
  func customAlert <Content: View> (isPresented: Bool, _ content: Content) -> some View {
    return self
      .modifier(Popup(isPresented: isPresented) { content })
  }
  
  // MARK: - Conditional Modifier
  @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if (condition) {
      transform(self)
    } else {
      self
    }
  }
  
  
  // MARK: - Alert Textfield
  func alertTF(title: String, message: String, hintText: String, primarytitle: String, secondaryTitle: String, primaryAction: @escaping (String) -> (), secondaryAction: @escaping () -> ()) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField {field in
      field.placeholder = hintText
    }
    
    alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
      secondaryAction()
    }))
    
    alert.addAction(.init(title: primarytitle, style: .default, handler: { _ in
      if let text = alert.textFields?[0].text {
        primaryAction(text)
      } else {
        primaryAction("")
      }
    }))
    
    // Presenting alert
    rootController().present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Root view
  func rootController() -> UIViewController {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return .init()
    }
    
    guard let root = screen.windows.first?.rootViewController else {
      return .init()
    }
    
    return root
  }
}
