//
//  CompaniesStore.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation

enum CompanySort: Equatable {
  case name
  case marketCap
}

class CompaniesStore {
  
  private let dataService: DataService
  private let apiService: APIService
  
  @MainActor var sort: CompanySort = .name {
    didSet {
      refresh()
    }
  }
  var companies = [Company]()
  
  var didRefresh: (() -> Void)?
  
  init(
    dataService: DataService = .init(),
    apiService: APIService = .init()
  ) {
    self.dataService = dataService
    self.apiService = apiService
  }
  
  // MARK: - Local data
  
  @MainActor func refresh() {
    var sortDescriptors = [SortDescriptor<Company>]()
    
    switch sort {
    case .name:
      sortDescriptors.append(SortDescriptor<Company>(\.name, order: .forward))
    case .marketCap:
      sortDescriptors.append(SortDescriptor<Company>(\.marketCap.raw, order: .reverse))
    }
    
    do {
      companies = try dataService.fetchData(
        type: Company.self,
        predicate: nil,
        sortDescriptors: sortDescriptors
      )
      didRefresh?()
    } catch {
      print("CompaniesStore.refresh(): Did fail to fetch: \(error)")
    }
  }
  
  @MainActor func toggleFavorite(company: Company) {
    company.isFavorite.toggle()
    refresh()
  }
  
  // MARK: - API
  
  func fetchFromAPI() {
    Task.detached {
      do {
        let companies: [Company?] = try await self.apiService.request(endpoint: CompanyEndpoints.companies)
        await self.didFetchFromAPI(companies: companies)
      } catch {
        print("CompaniesStore.fetchFromAPI(): Did fail to fetch: \(error)")
      }
    }
  }
  
  @MainActor func didFetchFromAPI(companies: [Company?]) {
    for company in companies {
      if let company {
        dataService.add(company)
      }
    }
    refresh()
  }
}
