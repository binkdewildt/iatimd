//
//  UIDeviceExtension.swift
//  FamilySpellen
//
//  Created by Bink de Wildt on 19/12/2021.
//

import Foundation
import UIKit

extension UIDevice {
  static var idiom: UIUserInterfaceIdiom {
    UIDevice.current.userInterfaceIdiom
  }

  static var isIpad: Bool {
    idiom == .pad
  }
  static var isIphone: Bool {
    idiom == .phone
  }

}
