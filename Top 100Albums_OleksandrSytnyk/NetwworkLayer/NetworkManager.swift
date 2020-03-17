//
//  NetworkManager.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  
  private var dataTask: URLSessionDataTask? = nil
  
  func getAlbums(successHandler: @escaping ([Album]) -> Void, errorHandler: @escaping (String?) -> Void) {
    let session = URLSession.shared
    guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/music-videos/top-music-videos/all/100/explicit.json") else {
      print("Wrong url!".localized)
      return
    }
    
    let task = session.dataTask(with: url) { data, response, error in
      
      if error != nil || data == nil {
        print("Client error!".localized)
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!".localized)
        return
      }
      
      guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type for albums!".localized)
        return
      }
      
      guard let data = data else {
        print("Wrong data!".localized)
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        if let albums = NetworkParsingManager.shared.parseAlbums(json: json) {
          successHandler(albums)
        } else {
          print("Data base doesn't contain albums.".localized)
        }
        
      } catch {
        print("JSON error: \(error.localizedDescription)")
      }
    }
    task.resume()
  }
  
  func getImage(from url: URL, successHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (String?) -> Void) -> Void {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if error != nil {
        print("Client error!".localized)
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!".localized)
        return
      }
      
      guard let mime = response.mimeType, mime.hasPrefix("image") else {
        print("Wrong MIME type!".localized)
        return
      }
      
      guard let data = data, let image = UIImage(data: data) else {
        print("Client error!".localized)
        return
      }
      successHandler(image)
    }
    task.resume()
  }
}
