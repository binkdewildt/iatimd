//
//  NetworkModels.swift
//  IATIMD
//
//  Created by Bink de Wildt on 16/06/2022.
//

import Foundation

enum NetworkErrors: Error, LocalizedError, Identifiable {
  case invalidURL
  case decodingError
  case unauthorized
  case serverError(_ code: Int)
  case failedRequest(Error)

  var id: String {
    self.localizedDescription
  }

}

struct EmptyBody: Codable {}
