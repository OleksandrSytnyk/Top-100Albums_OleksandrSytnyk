//
//  UIView_Extension.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/14/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

extension UIView {
  
  func setAnchors(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLead: CGFloat = 0, paddingBottom: CGFloat = 0, paddingTrail: CGFloat = 0, paddingCenterY: CGFloat = 0, paddingCenterX: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0, enableInsets: Bool = false) {
    var topInset = CGFloat(0)
    var bottomInset = CGFloat(0)
    
    if enableInsets {
      let insets = self.safeAreaInsets
      topInset = insets.top
      bottomInset = insets.bottom
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
    }
    if let leading = leading {
      self.leadingAnchor.constraint(equalTo: leading, constant: paddingLead).isActive = true
    }
    if let trailing = trailing {
      self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrail).isActive = true
    }
    if let bottom = bottom {
      self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
    }
    if let centerY = centerY {
      self.centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
    }
    if let centerX = centerX {
      self.centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
    }
    
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
  }
}
