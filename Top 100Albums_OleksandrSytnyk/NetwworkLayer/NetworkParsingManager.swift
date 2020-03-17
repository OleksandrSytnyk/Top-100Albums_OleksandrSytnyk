//
//  NetworkParsingManager.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

struct NetworkParsingManager {
  static let shared = NetworkParsingManager()
  
  enum ParsingError: Error {
    case invalidAlbumData
    case invalidAlbumDetailsData
    case noAlbumDetailsData
    
    func errorDescription() -> String {
      switch self {
      case .invalidAlbumData:
        return "Parsing failed: invalid album data provided.".localized
      case .invalidAlbumDetailsData:
        return "Parsing failed: invalid album details data provided.".localized
      case .noAlbumDetailsData:
        return "Data base doesn't contain details for this album.".localized
      }
    }
  }
  
  func parseAlbums(json: Any) -> [Album]? {
    var albums = [Album]()
    guard let json = json as? [String: Any], let feed = json["feed"] as? [String: Any], let results = feed["results"], let jsonAlbums = results as? [[String: Any]] else {
      return nil
    }
    
    for jsonAlbum in jsonAlbums {
      do {
        let album = try self.parseAlbum(jsonAlbum)
        albums.append(album)
      } catch {
        continue
      }
    }
    return albums
  }
  
  private func parseAlbum(_ json: [String: Any]) throws -> Album {
    var album = Album()
    
    guard let name = json["name"] as? String,
      let artistName = json["artistName"] as? String,
      let thumbnailURL = json["artworkUrl100"] as? String,
      let genres = json["genres"] as? [Any],
      let gengesDict  = genres[0] as? [String: String],
      let genreNames = gengesDict["name"],
      let releaseDate = json["releaseDate"] as? String,
      let copyright = json["copyright"] as? String,
      let url = json["url"] as? String else {
        throw ParsingError.invalidAlbumData
    }
    
    album.name = name
    album.artist = artistName
    album.thumbnailURL = URL(string: thumbnailURL)
    album.genres = genreNames
    album.releaseDate = releaseDate
    album.copyright = copyright
    album.url = URL(string: url)
    
    return album
  }
}

