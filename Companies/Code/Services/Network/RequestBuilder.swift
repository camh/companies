//
//  RequestBuilder.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

class RequestBuilder {
  func build<E: Endpoint>(_ endpoint: E) throws -> URLRequest {
    var urlRequest = URLRequest(url: try endpoint.asURL())
    urlRequest.httpMethod = endpoint.httpMethod
    return urlRequest
  }
}
