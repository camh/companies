//
//  DataService.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation
import SwiftData

enum DataServiceError: Error {
  case unknown
  case contextIsNil
}

class DataService {
  
  var container: ModelContainer?
  
  @MainActor var context: ModelContext? {
    container?.mainContext
  }
  
  init() {
    do {
      let schema = Schema([Company.self])
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
      container = try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      print("DataService: Error initializing ModelContainer:", error)
    }
  }
  
  @MainActor func add<Object: PersistentModel>(_ object: Object) {
    context?.insert(object)
  }
  
  @MainActor func delete<Object: PersistentModel>(_ object: Object) {
    context?.delete(object)
  }
  
  @MainActor func fetchData<Object: PersistentModel>(
    type: Object.Type,
    predicate: Predicate<Object>? = nil,
    sortDescriptors: [SortDescriptor<Object>] = []
  ) throws -> [Object] {
    guard let context else {
      throw DataServiceError.contextIsNil
    }
    let descriptor = FetchDescriptor<Object>(
      predicate: predicate,
      sortBy: sortDescriptors
    )
    return try context.fetch(descriptor)
  }
}
