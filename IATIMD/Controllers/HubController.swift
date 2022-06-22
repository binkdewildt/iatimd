//
//  HubController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 21/06/2022.
//

import Foundation
import SwiftUI

class HubController: ObservableObject {
  
  // MARK: - Properties
  @Published var showSettings: Bool = false
  @Published var showLocations: Bool = false
}
