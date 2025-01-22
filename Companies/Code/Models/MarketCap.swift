//
//  MarketCap.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation
import SwiftData

@Model
class MarketCap: Codable {
  
  enum CodingKeys: String, CodingKey {
    case fmt
    case longFmt
    case raw
  }
  
  var fmt: String
  var longFmt: String
  var raw: Int64
  
  init(fmt: String, longFmt: String, raw: Int64) {
    self.fmt = fmt
    self.longFmt = longFmt
    self.raw = raw
  }
  
  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.fmt = try container.decode(String.self, forKey: .fmt)
    self.longFmt = try container.decode(String.self, forKey: .longFmt)
    self.raw = try container.decode(Int64.self, forKey: .raw)
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(fmt, forKey: .fmt)
    try container.encode(longFmt, forKey: .longFmt)
    try container.encode(raw, forKey: .raw)
  }
}
