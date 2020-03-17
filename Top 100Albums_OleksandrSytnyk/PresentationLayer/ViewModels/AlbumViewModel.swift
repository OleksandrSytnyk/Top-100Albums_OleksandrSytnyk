//
//  Album.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

protocol AlbumPresentable {
  var name: NSMutableAttributedString { get }
  var artist: NSMutableAttributedString { get }
  var thumbnail: UIImage { get }
  var genres: NSMutableAttributedString { get }
  var releaseDate: NSMutableAttributedString { get }
  var copyright: NSMutableAttributedString { get }
  var url: URL? { get }
}

class AlbumViewModel {
  var album: Album
  var imageRecord: ImageRecord
  
  init(album: Album) {
    self.album = album
    self.imageRecord = ImageRecord(url: album.thumbnailURL, image: album.thumbnail)
  }
}

extension AlbumViewModel: AlbumPresentable {
  func getFormattingString(title: String, value: String) -> NSMutableAttributedString {
    let formattedString = NSMutableAttributedString()
    formattedString.append(title.localized, font:  UIFont.boldSystemFont(ofSize: 18))
    formattedString.append(value, font: UIFont.systemFont(ofSize: 14))
    
    return formattedString
  }
  
  var name: NSMutableAttributedString {
    return getFormattingString(title: "Name: ", value: album.name)
  }
  
  var artist: NSMutableAttributedString {
    return getFormattingString(title: "Artist: ", value: album.artist)
  }
  
  var thumbnail: UIImage {
    return imageRecord.image
  }
  
  var genres: NSMutableAttributedString {
    return getFormattingString(title: "Genres: ", value: album.genres)
  }
  
  var releaseDate: NSMutableAttributedString {
    return getFormattingString(title: "Release date: ", value: album.releaseDate)
  }
  
  var copyright: NSMutableAttributedString {
    return getFormattingString(title: "Copyright: ", value: album.copyright)
  }
  
  var url: URL? {
    return album.url
  }
}
