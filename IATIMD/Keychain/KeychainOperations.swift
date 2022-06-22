//
//  KeychainOperations.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import Foundation

internal class KeychainOperations: NSObject {
  
  // MARK: - Exists
  /**
   Function to check if we have an existing keychain `item`
   - parameters:
   - account: String type with the name of the item to check
   - returns: Boolean type with the answer if the item exists
  */
  static func exists(account: String) throws -> Bool {
    
    // Constant with current status about the keychain to check
    let status = SecItemCopyMatching([
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: account,
      kSecAttrService: service,
      kSecReturnData: false,
    ] as NSDictionary, nil)
    
    // Switch to conditioning statement
    switch status {
      case errSecSuccess:
        return true
        
      case errSecItemNotFound:
        return false
        
      default:
        throw keychainErrors.keychainCreatingError
    }
    
  } //: exists
  
  
  // MARK: - Add
  /**
    Function to add an item to the keychain
     - parameters:
     - value: Value to save in `data` format (String, Int, Double, Float, etc.)
     - account: Account name for keychain item
  */
  static func add(value: Data, account: String) throws {
    let status = SecItemAdd([
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: account,
      kSecAttrService: service,
      
      // Allow background access
      kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
      kSecValueData: value,
    ] as NSDictionary, nil)
    
    guard status  == errSecSuccess else { throw keychainErrors.operationError}
    
  } //: add
  
  
  
  // MARK: - Update
  /**
    Function to update an item in the keychain
     - parameters:
     - value: Value to replace for
     - account: Account name for keychain item
  */
  internal static func update(value: Data, account: String) throws {
    let status = SecItemUpdate([
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: account,
      kSecAttrService: service,
    ] as NSDictionary, [
      kSecValueData: value,
    ] as NSDictionary)
    
    guard status == errSecSuccess else { throw keychainErrors.operationError }
  } //: update
  
  
  // MARK: - Retreive
  /**
    Function to retreive an item from keychain
     - Parameyers:
     - account: Account name for keychain item
  */
  internal static func retreive(account: String) throws -> Data? {
    
    // Result of getting the item
    var result: AnyObject?
    let status = SecItemCopyMatching([
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: account,
      kSecAttrService: service,
      kSecReturnData: true
    ] as NSDictionary, &result)
    
    
    // Switch the conditioning statement
    switch status {
      case errSecSuccess:
        return result as? Data
      
      case errSecItemNotFound:
        return nil
      
      default:
        throw keychainErrors.operationError
    }
  } //: retreive
  
  
  
  /**
    Function to delete a single item
   - parameters:
   - account: Account name for keychain item
  */
  internal static func delete(account: String) throws {
    
    // Status for the query
    let status = SecItemDelete([
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: account,
      kSecAttrService: service,
    ] as NSDictionary)
    
    guard status == errSecSuccess else { throw keychainErrors.operationError}
    
  } //: delete
  
  
  /**
    Function to delete all items for the app
  */
  internal static func deleteAll() throws {
    let status = SecItemDelete([
      kSecClass: kSecClassGenericPassword,
    ] as NSDictionary)
    
    guard status == errSecSuccess else { throw keychainErrors.operationError }
  } //: deleteAll
  
}
