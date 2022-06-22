//
//  AuthModels.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

enum AuthError: Error, LocalizedError, Identifiable {
  case invalidCredentials
  case tokenExpired
  case passwordMismatch
  case emptyField
  case registrationError

  var id: String {
    self.localizedDescription
  }
  
  var errorDescription: String? {
    switch self {
      
      case .invalidCredentials:
        return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
      
      case .emptyField:
        return NSLocalizedString("Please fill in all the fields.", comment: "")
      
      case .passwordMismatch:
        return NSLocalizedString("The passwords do not match.", comment: "")
        
      case .registrationError:
        return NSLocalizedString("Error occurred during registration.", comment: "")
        
      default:
        return NSLocalizedString("", comment: "")
    }
  }

}



struct Credentials: Codable {
  
  // Properties
  var userID: String = ""
  var username: String = ""
  var email: String = ""
  var password: String = ""
  
  var access_token: String = ""
  var token_type: String = ""
  
  
  // Functions
  func encode() -> String {
    let encoder = JSONEncoder()
    let credentialData = try! encoder.encode(self)
    return String(data: credentialData, encoding: .utf8)!
  }
  
  static func decode(_ credentialsString: String) -> Credentials {
    let decoder = JSONDecoder()
    let jsonData = credentialsString.data(using: .utf8)
    return try! decoder.decode((Credentials.self), from: jsonData!)
  }
}


// MARK: - Body sent with login
struct LoginBody: Codable {
  var email: String
  var password: String
}

// MARK: - Response body after login
struct LoginResponse: Codable {
  var access_token: String
  var token_type: String
  var user: UserResponse
}


// MARK: - Body sent with checking if valid
struct ValidBody: Codable {
  var userID: String
}

// MARK: - Response with the acces token
struct TokenResponse: Codable {
  var access_token: String
  var token_type: String
}


// MARK: - Register body
struct RegisterBody: Codable {
  var name: String
  var email: String
  var password: String
}
