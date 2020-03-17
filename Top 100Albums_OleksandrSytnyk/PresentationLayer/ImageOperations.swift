//
//  ImageOperations.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

class PendingOperations {
  lazy var downloadsInProgress: [IndexPath: Operation] = [:]
  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "DownloadQueue"
    return queue
  }()
}

class ImageDownloader: Operation {
  let imageRecord: ImageRecord
  
  init(_ imageRecord: ImageRecord) {
    self.imageRecord = imageRecord
  }
  
  override func main() {
    if isCancelled {
      return
    }
    guard let url = imageRecord.url else { return }
    
    BusinessManager.shared.getImage(from: url, successHandler: { [weak self] image in
      guard let strongSelf = self else { return }
      strongSelf.imageRecord.image = image
      strongSelf.imageRecord.state = .downloaded
      }, errorHandler: {[weak self] error in
        guard let strongSelf = self else { return }
        strongSelf.imageRecord.state = .failed
        strongSelf.imageRecord.image = UIImage()
    })
  }
}
