//
//  Endpoint.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var httpMethod: String { get }
  var pathComponents: [String] { get }
  var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
  var scheme: String {
    "https"
  }
}

extension Endpoint {
  func asURL() throws -> URL {
    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }
    return url
  }
  
  var urlComponents: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.host = host
    urlComponents.scheme = scheme
    let path = "/" + pathComponents.joined(separator: "/")
    urlComponents.path =  path
    urlComponents.queryItems = queryItems
    return urlComponents
  }
}
