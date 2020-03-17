//
//  AlbumDetailsViewController.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
  var album: Album?
  var image: UIImage?
  var iTunesURL: URL?
  
  private let albumImageView : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
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
  
  private let genresLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let releaseDateLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let copyrightLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let showInITunesButton : UIButton = {
    let btn = UIButton(type: .custom)
    btn.backgroundColor = .lightGray
    btn.addTarget(self, action: #selector(showInITunesButtonTapped), for: .touchUpInside)
    btn.setTitleColor(.black, for: .normal)
    btn.setTitle("iTunes".localized,for: .normal)
    btn.isUserInteractionEnabled = true
    return btn
  }()
  
  @objc func showInITunesButtonTapped(intensity: Int) {
    guard let iTunesURL = iTunesURL else { return }
    UIApplication.shared.open(iTunesURL)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setSubviews()
  }
  
  func setSubviews() {
    navigationItem.title = "Album Details".localized
    
    albumImageView.image = image
    view.addSubview(albumImageView)
    
    if let image = image {
      let albumImageViewWidth: CGFloat = 300
      let albumImageViewHeight = albumImageViewWidth * (image.size.height/image.size.width)
      albumImageView.setAnchors(top: view.topAnchor, centerX: view.centerXAnchor, paddingTop: 100, width: albumImageViewWidth, height: albumImageViewHeight, enableInsets: true)
    }
    let stackView = UIStackView(arrangedSubviews: [nameLabel,artistLabel, genresLabel, releaseDateLabel, copyrightLabel])
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    stackView.spacing = 5
    view.addSubview(stackView)
    stackView.setAnchors(top: albumImageView.bottomAnchor, centerX: view.centerXAnchor, paddingTop: 10,  width: 200)
    
    view.addSubview(showInITunesButton)
    showInITunesButton.setAnchors(top: stackView.bottomAnchor, centerX: view.centerXAnchor, paddingTop: 20, width: 70, height: 30)
  }
  
  func configure(albumViewModel: AlbumPresentable) {
    nameLabel.attributedText = albumViewModel.name
    artistLabel.attributedText = albumViewModel.artist
    genresLabel.attributedText = albumViewModel.genres
    releaseDateLabel.attributedText = albumViewModel.releaseDate
    copyrightLabel.attributedText = albumViewModel.copyright
    albumImageView.image = albumViewModel.thumbnail
    iTunesURL = albumViewModel.url
  }
}
