//
//  UIScrollView.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 26/05/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    // Pull to refresh
    func addRefreshControl(action: (() -> Void)?) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .hyddblue
        refreshControl.addAction(for: .valueChanged) {
            if let refreshAction = action {
                refreshAction()
            }
        }
        self.addSubview(refreshControl)
    }
    
    func endRefreshing() {
        for view in self.subviews {
            if let refreshControl = view as? UIRefreshControl {
                refreshControl.endRefreshing()
                break
            }
        }
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        
    }
}
var AssociatedObjectHandle: UInt8 = 0

class ClosureSleeve {
    let closure: () -> Void
    
    init(attachTo: AnyObject, closure: @escaping () -> Void) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, &AssociatedObjectHandle, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc func invoke() {
        closure()
    }
}
