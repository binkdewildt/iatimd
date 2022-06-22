//
//  AuthController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

class Authenticate: ObservableObject {
  
  // MARK: - Singleton
  private init() {
    
    if let credentials = KeychainStorage.getCredentials() {
      
      // Set the user properties
      user = User(
        id: credentials.userID,
        name: credentials.username,
        email: credentials.email,
        password: credentials.password,
        access_token: credentials.access_token,
        tokenType: credentials.token_type
      )
      
      isValidated = true
      
    }
    
  }
  static let shared: Authenticate = Authenticate()
  
  // MARK: - Properties
  @Published var isRegistering: Bool = false
  @Published var error: Error?
  @Published var user: User?
  @Published var isValidated: Bool = false
  @Published var stayLoggedIn: Bool = true
  
  
  
  // MARK: - Methods
  func login(email: String, password: String) {
    
    if (email.isEmpty || password.isEmpty) {
      self.error = AuthError.emptyField
      return
    }
    
    // Clear the previous variables
    self.error = nil
    
    let body = LoginBody(email: email, password: password)
    Network.shared.login(body) { (result) in
      switch result {
        case .success(let encodedData):
        
          // Decode the data
          guard let data = try? JSONDecoder().decode(LoginResponse.self, from: encodedData) else {
            return
          }
        
          // Save the new user
          self.user = User(
            id: data.user.id,
            name: data.user.name,
            email: email,
            password: password,
            access_token: data.access_token,
            tokenType: data.token_type
          )
        
          // Save in Keychain
          if (self.stayLoggedIn) {
            KeychainStorage.saveCredentials(
              Credentials(
                userID: data.user.id,
                username: data.user.name,
                email: email,
                password: password,
                access_token: data.access_token,
                token_type: data.token_type
              )
            )
          }
          
          // Set validated
          self.isValidated = true
                
      case .failure(let error):
        switch error {
          case .serverError(let code):
            if (code == 400) {
              self.error = AuthError.invalidCredentials
            }
            else if (code == 404) {
              self.error = NetworkErrors.invalidURL
            }
            
          default:
            return
        }
      }
    }
    
  }
  func register(username: String, email: String, password: String, confirmPassword: String) {
    
    if (email.isEmpty || password.isEmpty || username.isEmpty || confirmPassword.isEmpty) {
      self.error = AuthError.emptyField
      return
    }
    
    // Check if passwords are the same
    if (password != confirmPassword) {
      self.error = AuthError.passwordMismatch
      return
    }
    
    // Send the request
    let body = RegisterBody(name: username, email: email, password: password)
    
    Network.shared.register(body) { (result) in
      print(result)
      switch result {
        case .success(let encodedData):
        
          // Decode the data
          guard let data = try? JSONDecoder().decode(TokenResponse.self, from: encodedData) else {
            print("Error")
            return
          }
        
          // Save the new user
          self.user = User(
            id: "",
            name: username,
            email: email,
            password: password,
            access_token: data.access_token,
            tokenType: data.token_type
          )
        
          // Save in Keychain
          if (self.stayLoggedIn) {
            KeychainStorage.saveCredentials(
              Credentials(
                userID: "",
                username: username,
                email: email,
                password: password,
                access_token: data.access_token,
                token_type: data.token_type
              )
            )
          }
          
          // Set validated
          self.isValidated = true
                
      case .failure(let error):
        switch error {
          case .serverError(let code):
            if (code == 400) {
              self.error = AuthError.registrationError
            }
            else if (code == 404) {
              self.error = NetworkErrors.invalidURL
            }
            
          default:
            return
        }
      }
    }
  }
  func logout() {
    KeychainStorage.deleteCredentials()
    
    self.isValidated = false;
    return;
  }
}



func authToken() -> String {
  
  if let user = Authenticate.shared.user {
    return "\(user.tokenType) \(user.access_token)"
  }
  
  return ""
}
