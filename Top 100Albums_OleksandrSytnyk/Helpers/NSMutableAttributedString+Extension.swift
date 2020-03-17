//
//  NSMutableAttributedString+Extension.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
  @discardableResult func append(_ text: String, font: UIFont) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [.font: font]
    let boldString = NSMutableAttributedString(string: text, attributes: attrs)
    append(boldString)
    
    return self
  }
}
