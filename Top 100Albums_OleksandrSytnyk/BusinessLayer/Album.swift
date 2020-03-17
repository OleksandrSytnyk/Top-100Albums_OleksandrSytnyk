//
//  Album.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

struct Album {
  var name = ""
  var artist = ""
  var thumbnailURL: URL?
  var thumbnail = UIImage()
  var genres = ""
  var releaseDate = ""
  var copyright = ""
  var url: URL?
}
