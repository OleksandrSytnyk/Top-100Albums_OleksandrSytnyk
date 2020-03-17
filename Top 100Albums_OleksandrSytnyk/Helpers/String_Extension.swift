//
//  String_Extension.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
