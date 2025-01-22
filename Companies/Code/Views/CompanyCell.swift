//
//  CompanyCell.swift
//  Companies
//
//  Created by Cam Hunt on 1/22/25.
//

import Foundation
import UIKit

class CompanyCell: UIView, UIContentView {
  
  let symbolLabel = UILabel()
  let nameLabel = UILabel()
  let fmtLabel = UILabel()
  
  let favoriteButton = UIButton(type: .custom)
  var didTapFavoriteButton: (() -> Void)?
  
  init(
    configuration: Configuration
  ) {
    self.configuration = configuration
    super.init(frame: .zero)
    
    directionalLayoutMargins = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    
    symbolLabel.font = .preferredFont(forTextStyle: .title1)
    symbolLabel.textColor = .systemBlue
    
    nameLabel.font = .preferredFont(forTextStyle: .body)
    
    fmtLabel.font = .preferredFont(forTextStyle: .title1)
    fmtLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    fmtLabel.textAlignment = .right
    
    favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    
    for view in [symbolLabel, nameLabel, fmtLabel, favoriteButton] {
      addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate(
      [
        symbolLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        symbolLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        
        nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
        nameLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        
        fmtLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 10),
        fmtLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        fmtLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        
        favoriteButton.leadingAnchor.constraint(equalTo: fmtLabel.trailingAnchor, constant: 10),
        favoriteButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        favoriteButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        favoriteButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      ]
    )
    
    configure()
  }

  required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Actions
  
  @objc private func favoriteButtonTapped() {
    didTapFavoriteButton?()
  }

  // MARK: Configuration

  struct Configuration: UIContentConfiguration {
    
    var name: String
    var symbol: String
    var fmt: String
    var isFavorite: Bool
    
    var didTapFavoriteButton: (() -> Void)?
    
    func makeContentView() -> UIView & UIContentView {
      CompanyCell(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> Configuration {
      self
    }
  }

  var configuration: UIContentConfiguration {
    didSet {
      configure()
    }
  }

  private func configure() {
    guard let configuration = configuration as? Configuration else { return }
    
    self.nameLabel.text = configuration.name
    self.symbolLabel.text = configuration.symbol
    self.fmtLabel.text = configuration.fmt
    
    if configuration.isFavorite {
      favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    } else {
      favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    didTapFavoriteButton = configuration.didTapFavoriteButton
  }
}

