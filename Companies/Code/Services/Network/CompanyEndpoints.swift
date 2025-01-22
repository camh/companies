//
//  CompanyEndpoints.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

enum CompanyEndpoints: Endpoint {
  case companies
  
  var host: String {
    "us-central1-fbconfig-90755.cloudfunctions.net"
  }
  
  var httpMethod: String {
    switch self {
    case .companies:
      "GET"
    }
  }
  
  var pathComponents: [String] {
    switch self {
    case .companies:
      return ["getAllCompanies"]
    }
  }
  
  var queryItems: [URLQueryItem]? {
    nil
  }
}
