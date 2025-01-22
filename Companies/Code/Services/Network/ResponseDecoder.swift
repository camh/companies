//
//  ResponseDecoder.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

class ResponseDecoder {
  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    let jsonDecoder = JSONDecoder()
    return try jsonDecoder.decode(type, from: data)
  }
}
