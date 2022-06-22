//
//  AlertController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

class AlertController: ObservableObject {
  
  // MARK: - Properties
  @Published var show: Bool = false
  
  var alertType: AlertTypes = .normal
  var title: String = ""
  var text: String = ""
  var image: String = ""
  var dismissText: String?
  var action: () -> Void = {}
  var dismissAction: () -> Void = {}
  
  
  // MARK: - Methods
  func showAlert(
    type: AlertTypes = .normal,
    title: String = "",
    text: String = "",
    image: String = "",
    dismissText: String = "",
    action: @escaping () -> Void,
    dismissAction: @escaping () -> Void
  ) {
    self.alertType = type
    self.title = title
    self.text = text
    self.image = image
    self.dismissText = dismissText
    self.action = action
    self.dismissAction = dismissAction
    
    self.show = true
  }
  
  func closeAlert() {
    self.show = false
    self.title = ""
    self.text = ""
    self.image = ""
    self.dismissText = ""
    self.action = {}
    self.dismissAction = {}
  }
  
}
