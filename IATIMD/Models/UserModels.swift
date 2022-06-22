//
//  UserModels.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

struct User {
  var id: String
  var name: String
  var email: String
  var password: String
  
  var access_token: String
  var tokenType: String
}

struct UserResponse: Codable {
  var id: String
  var name: String
  var email: String
  var password: String
}
