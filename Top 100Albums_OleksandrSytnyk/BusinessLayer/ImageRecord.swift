//
//  ImageRecord.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

// This enum contains all the possible states of a image record
enum ImageRecordState {
  case new, downloaded, failed
}

class ImageRecord {
  let url: URL?
  var state = ImageRecordState.new
  var image: UIImage
  
  init(url: URL?, image: UIImage) {
    self.url = url
    self.image = image
  }
}
