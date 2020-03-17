//
//  AlbumCell.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
  private let nameLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let artistLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  let albumImageView : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    return imgView
  }()
  
  let albumImageViewWidth: CGFloat = 90
  let albumImageViewPadding: CGFloat = 15
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    commonInit()
  }
  
  func commonInit() {
    if accessoryView == nil {
      let indicator = UIActivityIndicatorView(style: .medium)
      accessoryView = indicator
    }
    
    contentView.addSubview(albumImageView)
    albumImageView.translatesAutoresizingMaskIntoConstraints = false
    
    
    albumImageView.setAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, paddingLead: albumImageViewPadding, width: albumImageViewWidth)
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(artistLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    artistLabel.translatesAutoresizingMaskIntoConstraints = false
    
    nameLabel.setAnchors(leading: albumImageView.trailingAnchor, trailing: contentView.layoutMarginsGuide.trailingAnchor, paddingLead: albumImageViewPadding )
    
    artistLabel.setAnchors(leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor)
    
    nameLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
    
    contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: artistLabel.lastBaselineAnchor, multiplier: 1).isActive = true
    
    artistLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: nameLabel.lastBaselineAnchor, multiplier: 1).isActive = true
  }
  
  deinit {
    albumImageView.image = nil
  }
  
  func configure(albumViewModel: AlbumPresentable) {
    nameLabel.attributedText = albumViewModel.name
    artistLabel.attributedText = albumViewModel.artist
    albumImageView.image = albumViewModel.thumbnail
  }
}
