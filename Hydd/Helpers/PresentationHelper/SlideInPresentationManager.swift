//
//  SlideInPresentationManager.swift
//  Sippy
//
//  Created by Kashan on 09/10/2019.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.

import UIKit

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {
  // MARK: - Properties
    var direction: PresentationDirection = .left
    var disableCompactHeight = false
    var height: CGFloat = (2.0/3.0)
    var width: CGFloat = (2.0/3.0)
    var xAxis: CGFloat = 0
    var yAxis: CGFloat = (2.0/3.0)
    var isTapEnabled: Bool = true
    var topViewController = UIViewController()
    
}

// MARK: - UIViewControllerTransitioningDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
let presentationController = SlideInPresentationController(
    presentedViewController: presented,
    presenting: presenting,
    direction: direction,
    xAxis: xAxis,
    yAxis: yAxis,
    width: width,
    height: height,
    topVC: topViewController,
    isTap: isTapEnabled
)
presentationController.delegate = self
return presentationController
}

  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return SlideInPresentationAnimator(direction: direction, isPresentation: true)
  }

  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return SlideInPresentationAnimator(direction: direction, isPresentation: false)
  }
    func justcheck() {
        printHydd("just Checked")
    }
    
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
  func adaptivePresentationStyle(
    for controller: UIPresentationController,
    traitCollection: UITraitCollection
  ) -> UIModalPresentationStyle {
    if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
      return .overFullScreen
    } else {
      return .none
    }
  }
  
  func presentationController(
    _ controller: UIPresentationController,
    viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle
  ) -> UIViewController? {
    guard case(.overFullScreen) = style else { return nil }
    return UIViewController()
  }
}
