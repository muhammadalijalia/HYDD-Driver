//
//  SlideInPresentationController.swift
//  Sippy
//
//  Created by Kashan on 09/10/2019.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.

import UIKit

final class SlideInPresentationController: UIPresentationController {
  // MARK: - Properties
  private var dimmingView: UIView!
  private let direction: PresentationDirection
    var xAxis: CGFloat
    var yAxis: CGFloat
    var width: CGFloat
    var height: CGFloat
    var topVC: UIViewController
    var isTapDismiss: Bool
  
  override var frameOfPresentedViewInContainerView: CGRect {
    var frame: CGRect = .zero
    frame.size = size(forChildContentContainer: presentedViewController,
                      withParentContainerSize: containerView!.bounds.size)
    
    switch direction {
    case .right:
      frame.origin.x = containerView!.frame.width*(xAxis)
    case .bottom:
      frame.origin.y = containerView!.frame.height*(yAxis)
    case .left:
        frame.origin.x = containerView!.frame.width*(xAxis)
    default:
      frame.origin = .zero
    }
    return frame
  }
  
  // MARK: - Initializers
  init(presentedViewController: UIViewController,
       presenting presentingViewController: UIViewController?,
       direction: PresentationDirection,
       xAxis: CGFloat,
       yAxis: CGFloat,
       width: CGFloat,
       height: CGFloat,
       topVC: UIViewController,
       isTap: Bool) {
    self.direction = direction
    self.xAxis = xAxis
    self.yAxis = yAxis
    self.width = width
    self.height = height
    self.topVC = topVC
    self.isTapDismiss = isTap
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    setupDimmingView()
  }
  
  override func presentationTransitionWillBegin() {
    guard let dimmingView = dimmingView else {
      return
    }
    containerView?.insertSubview(dimmingView, at: 0)
    
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["dimmingView": dimmingView]))
    
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["dimmingView": dimmingView]))
    
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 1.0
      return
    }
    
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1.0
    })
  }
  
  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.0
      return
    }
    
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }
  
  override func size(forChildContentContainer container: UIContentContainer,
                     withParentContainerSize parentSize: CGSize) -> CGSize {
    switch direction {
    case .left, .right:
        return CGSize(width: parentSize.width*(self.width), height: parentSize.height)
    case .bottom, .top:
        return CGSize(width: parentSize.width, height: parentSize.height*(self.height))
    }
  }
}

// MARK: - Private
private extension SlideInPresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
    dimmingView.alpha = 0.0
    
    if isTapDismiss {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    print(presentingViewController)
    UIView.animate(withDuration: 0.3) {
        self.topVC.view.frame.origin.x = 0
    }
    presentingViewController.dismiss(animated: true)
  }
}
