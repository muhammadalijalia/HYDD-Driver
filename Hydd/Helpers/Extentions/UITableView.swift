//
//  UITableViewExtension.swift
//  Hydd
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UITableView {
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        let numberOfSections = self.numberOfSections
        if numberOfSections <= 0 { return }
        let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections-1))
            self.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: animated)
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Gibson-Regular", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}
