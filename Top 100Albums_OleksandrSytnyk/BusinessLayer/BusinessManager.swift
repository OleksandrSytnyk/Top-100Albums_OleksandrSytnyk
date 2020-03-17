//
//  BusinessManager.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import  UIKit

struct BusinessManager {
  static let shared = BusinessManager()
  
  func getAlbums(successHandler: @escaping ([Album]) -> Void, errorHandler: @escaping (String?) -> Void) {
    NetworkManager.shared.getAlbums(successHandler: successHandler, errorHandler: errorHandler)
  }
  
  func getImage(from url: URL, successHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (String?) -> Void) {
    NetworkManager.shared.getImage(from: url, successHandler: successHandler, errorHandler: errorHandler)
  }
}
