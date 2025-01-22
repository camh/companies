//
//  CompaniesViewController.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import UIKit

class CompaniesViewController: UICollectionViewController {
  
  enum Section {
    case companies
  }
  
  let store = CompaniesStore()
  var dataSource: UICollectionViewDiffableDataSource<Section, Company>?
  
  init() {
    let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
    super.init(collectionViewLayout: layout)
    
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CompanyCell")
    
    store.didRefresh = { [weak self] in
      self?.updateSnapshot()
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: nil,
      image: UIImage(systemName: "arrow.up.arrow.down"),
      primaryAction: nil,
      menu: sortMenu
    )
    
    createDataSource()
    
    store.refresh()
    updateSnapshot()
    
    store.fetchFromAPI()
  }
  
  // - Data Source
  
  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, company in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "CompanyCell",
          for: indexPath
        )

        let configuration = CompanyCell.Configuration(
          name: company.name,
          symbol: company.symbol,
          fmt: company.marketCap.fmt,
          isFavorite: company.isFavorite) { [weak self] in
            self?.store.toggleFavorite(company: company)
          }
        cell.contentConfiguration = configuration

        return cell
      }
    )
  }
  
  func updateSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Company>()
    snapshot.appendSections([.companies])
    snapshot.appendItems(store.companies)
    
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  // MARK: - Sort menu
  
  var sortMenu: UIMenu {
    let nameAction = UIAction(title: "Name", state: store.sort == .name ? .on : .off) { _ in
      self.store.sort = .name
    }
    let marketCapAction = UIAction(title: "Market cap", state: store.sort == .marketCap ? .on : .off) { _ in
      self.store.sort = .marketCap
    }
    return UIMenu(title: "Sort by", image: nil, identifier: nil, options: [], children: [
      nameAction,
      marketCapAction
      ]
    )
  }
}

