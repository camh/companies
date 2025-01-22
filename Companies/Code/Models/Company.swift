//
//  Company.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation
import SwiftData

@Model
class Company: Codable {
  
  enum CodingKeys: String, CodingKey {
    case name
    case symbol
    case marketCap
    case isFavorite
  }
  
  var name: String
  @Attribute(.unique) var symbol: String
  var marketCap: MarketCap
  var isFavorite: Bool = false
  
  init(
    name: String,
    symbol: String,
    marketCap: MarketCap,
    isFavorite: Bool
  ) {
    self.name = name
    self.symbol = symbol
    self.marketCap = marketCap
    self.isFavorite = isFavorite
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.symbol = try container.decode(String.self, forKey: .symbol)
    self.marketCap = try container.decode(MarketCap.self, forKey: .marketCap)
    self.isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(symbol, forKey: .symbol)
    try container.encode(marketCap, forKey: .marketCap)
    try container.encode(isFavorite, forKey: .isFavorite)
  }
}
