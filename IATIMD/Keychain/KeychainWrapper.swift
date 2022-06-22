//
//  KeychainWrapper.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

class KeychainWrapper {
  /**
   Function to store a keychain item
   - parameters:
   - value: Value to store in keychain in `data` format
   - account: Account name for keychain item
  */
  public static func set(value: Data, account: String) throws {
    
    // If the value exists -> update the value
    if try KeychainOperations.exists(account: account) {
      
    } else {
      // Insert
      try KeychainOperations.add(value: value, account: account)
    }
  } //: set
  
  
  /**
   Function to retreive an item in `Data` format (If not present, returns nil)
   - parameters:
   - account: Account name for keychain item
   - returns: Data from stored item
  */
  public static func get(account: String) throws -> Data? {
    if try KeychainOperations.exists(account: account) {
      return try KeychainOperations.retreive(account: account)
    } else {
      throw keychainErrors.operationError
    }
  } //: get
  
  
  /**
   Function to delete a single item
   - parameters:
   - account: Account name for keychain item
  */
  public static func delete(account: String) throws {
    if try KeychainOperations.exists(account: account) {
      return try KeychainOperations.delete(account: account)
    } else {
      throw keychainErrors.operationError
    }
  } //: delete
  
  
  /**
   Function to delete all items
  */
  public static func deleteAll() throws {
    try KeychainOperations.deleteAll()
  } //: deleteAll
}
