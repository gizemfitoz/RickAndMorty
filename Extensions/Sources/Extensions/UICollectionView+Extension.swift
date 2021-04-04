//
//  UICollectionView+Extension.swift
//  
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import UIKit

public extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Noto Sans Oriya", size: 16)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
