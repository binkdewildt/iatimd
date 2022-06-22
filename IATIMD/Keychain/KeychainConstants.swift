//
//  KeychainConstants.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

// Name of service
internal let service: String = "mySecretKeychainService"

/**
  Private enum to return possible errors
*/
internal enum keychainErrors: Error {
  
  // Error with the keychain creating and checking
  case keychainCreatingError
  
  // Error for operation
  case operationError
}
