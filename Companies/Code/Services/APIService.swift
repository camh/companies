//
//  APIService.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

class APIService {
  
  let network: Network
  let requestBuilder: RequestBuilder
  let responseDecoder: ResponseDecoder
  
  init(
    network: Network = Network(),
    requestBuilder: RequestBuilder = RequestBuilder(),
    responseDecoder: ResponseDecoder = ResponseDecoder()
  ) {
    self.network = network
    self.requestBuilder = requestBuilder
    self.responseDecoder = responseDecoder
  }
  
  func request<T: Decodable>(endpoint: Endpoint) async throws -> T where T: Decodable {
    let request = try requestBuilder.build(endpoint)
    let data = try await network.data(for: request)
    let object = try responseDecoder.decode(T.self, from: data)
    return object
  }
}
