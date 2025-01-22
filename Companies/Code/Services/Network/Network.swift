//
//  Network.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

class Network {
  let urlSession: URLSession
  
  init(urlSession: URLSession = .shared) {
    self.urlSession = urlSession
  }
  
  func data(for request: URLRequest) async throws -> Data {
    let (data, response) = try await urlSession.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.unknown)
    }
    
    if (200...299).contains(httpResponse.statusCode) {
      return data
    } else {
      throw URLError(.badServerResponse)
    }
  }
}
