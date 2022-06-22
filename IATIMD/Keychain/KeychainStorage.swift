//
//  KeychainStorage.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation


enum KeychainStorage {
  static let key = "credentials"
  
  static func getCredentials() -> Credentials? {
    if let myCredentialsString = try? KeychainWrapper.get(account: key) {
      let credentialsString = String(decoding: myCredentialsString, as: UTF8.self)
      return Credentials.decode(credentialsString)
    } else {
      return nil
    }
  } //: getCredentials
  
  
  static func saveCredentials(_ credentials: Credentials) {
    
    // If able to store...
    do {
      try KeychainWrapper.set(value: Data(credentials.encode().utf8), account: key)
    }
    catch { print("Error: ", error) }
  } //: saveCredentials
  
  
  static func deleteCredentials() {
    
    // Check if exists
    do {
      try KeychainWrapper.delete(account: key)
    }
    catch { print("Error: ", error) }
    
  } //: deleteCredentials
  
}
