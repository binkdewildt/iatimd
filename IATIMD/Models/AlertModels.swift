//
//  AlertModels.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation
import SwiftUI

enum AlertTypes {
  
  // MARK: - Cases
  case normal
  case error
  case confirm
  case help
  
  // MARK: - Properties
  var defaultTitle: String {
    switch self {
    case .normal:
      return "Congratulations"
    case .error:
      return "Oops!"
    case .confirm:
      return "Confirm"
    case .help:
      return "Info"
    }
  }
  
  var image: String {
    switch self {
    case .normal:
      return "checkmark"
    case .error:
      return "xmark"
    case .confirm:
      return "info"
    case .help:
      return "questionmark"
    }
  }
  
  var defaultButtonText: String {
    switch self {
    case .normal:
      return "Done"
    case .error:
      return "Done"
    case .confirm:
      return "Confirm"
    case .help:
      return "Got it"
    }
  }
  
  var defaultColor: Color {
    switch self {
    case .normal:
      return Color.accentColor
    case .error:
      return Color("Red")
    case .confirm:
      return Color.accentColor
    case .help:
      return Color.accentColor
    }
  }
  
  
}
