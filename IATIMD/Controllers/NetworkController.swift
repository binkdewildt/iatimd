//
//  NetworkController.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import Combine
import Foundation

public class Network {
  	
  // MARK: - Enum
  enum httpMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
  }
  
  // MARK: - Singleton
  private init() {}
  static let shared: Network = Network()
  var cancellables = Set<AnyCancellable>()
  
  
  
  // MARK: - Properties
  let mainURL = "https://www.mc22.nl/iatimd"
  private let token = authToken()
  
  
  
  // MARK: - Methods which perform network actions/Users/bink/Desktop/IATIMD/IATIMD/Keychain
  
  /**
      Function to retreive data from the web
        - parameters:
        - webAddress: mainURL + URL to get the data from
        - id: ID to identify the user by the server
        - completion: gets passed to the main function, handles the response
        - returns: Decoded data response from the server
  */
  func httpGET<T: Decodable>(webAddress: String, id: String, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        
    // 1. Generate the URL
    guard let url = URL(string: "\(mainURL)/\(webAddress)?id=\(id)") else {
      completion(.failure(.invalidURL))
      return
    }
    
    // 2. Send the request
    var request = URLRequest(url: url)
    if (!token.isEmpty) { request.setValue(token, forHTTPHeaderField: "Authorization") }
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    
    URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { output in
        if let response = output.response as? HTTPURLResponse {
          // If not 200 OK
          if (response.statusCode != 200) {
            
            if (response.statusCode == 401) { completion(.failure(.unauthorized)) }
            else { completion(.failure(.serverError(response.statusCode))) }
          }
        }
        return output.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .sink { (taskCompletion) in
        switch taskCompletion {
          case .finished:
            return
            
          case.failure(_):
            completion(.failure(.decodingError))
        }
      } receiveValue: { (decodedData) in
        completion(.success(decodedData))
      }
      .store(in: &cancellables)
    
  } //: httpGET
  
  
  /**
      Function to send data to a webserver
        - parameters:
        - webAddress: mainURL + URL to get the data from
        - method: contains the HTTP Method wich will be used for the network call
        - returns: Decoded data response from the server
  */
  func httpOther<T: Encodable>(webAddress: String, body: T? = nil, method: httpMethods, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
    
    // 1. Generate the URL
    guard let url = URL(string: "\(mainURL)/\(webAddress)") else {
      completion(.failure(.invalidURL))
      return
    }
    
    // 2. Send the request
    var request = URLRequest(url: url)
    if (!token.isEmpty) { request.setValue(token, forHTTPHeaderField: "Authorization") }
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method.rawValue
    request.httpBody = try? JSONEncoder().encode(body)
    
    URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { output in
        if let response = output.response as? HTTPURLResponse {
          
          // If not 200 OK
          if (response.statusCode != 200) {
            if (response.statusCode == 401) { completion(.failure(.unauthorized)) }
            else { completion(.failure(.serverError(response.statusCode))) }
          }
        }
        
        return output.data
      }
      .receive(on: RunLoop.main)
      .sink { (taskCompletion) in
        switch taskCompletion {
          case .finished:
            return
            
          case.failure(_):
            completion(.failure(.decodingError))
        }
      } receiveValue: { (decodedData) in
        completion(.success(decodedData))
      }
      .store(in: &cancellables)
    
  } //: httpOther
  
  func httpDELETE(webAddress: String, id: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        
    // 1. Generate the URL
    guard let url = URL(string: "\(mainURL)/\(webAddress)?id=\(id)") else {
      completion(.failure(.invalidURL))
      return
    }
    
    // 2. Send the request
    var request = URLRequest(url: url)
    if (!token.isEmpty) { request.setValue(token, forHTTPHeaderField: "Authorization") }
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "DELETE"

    
    URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { output in
        if let response = output.response as? HTTPURLResponse {
          // If not 200 OK
          if (response.statusCode != 200) {
            
            if (response.statusCode == 401) { completion(.failure(.unauthorized)) }
            else { completion(.failure(.serverError(response.statusCode))) }
          }
        }
        return output.data
      }
      .receive(on: RunLoop.main)
      .sink { (taskCompletion) in
        switch taskCompletion {
          case .finished:
            return
            
          case.failure(_):
            completion(.failure(.decodingError))
        }
      } receiveValue: { (decodedData) in
        completion(.success(decodedData))
      }
      .store(in: &cancellables)
    
  } //: httpGET
  
  
  // MARK: - Map
  func getAllPins(completion: @escaping (Result<[LocationResponse], NetworkErrors>) -> Void) {
    httpGET(
      webAddress: "locations.php",
      id: "",
      completion: completion
    )
  }
  func postPin(_ body: MapLocation, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
    httpOther(
      webAddress: "locations.php",
      body: body,
      method: .post,
      completion: completion
    )
  }
  func deletePin(_ id: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
    httpDELETE(
      webAddress: "locations.php",
      id: id,
      completion: completion
    )
  }
  
  
  // MARK: - Login
  func login(
    _ body: LoginBody,
    completion: @escaping (Result<Data, NetworkErrors>
    ) -> Void) {
      httpOther(
        webAddress: "login.php",
        body: body,
        method: .post,
        completion: completion
      )
  }
  func register(
    _ body: RegisterBody,
    completion: @escaping (Result<Data, NetworkErrors>
    ) -> Void) {
      httpOther(
        webAddress: "register.php",
        body: body,
        method: .post,
        completion: completion
      )
  }
}
