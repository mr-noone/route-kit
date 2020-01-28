//
//  DimmingPresentationController.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 28.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

open class DimmingPresentationController: UIPresentationController {
  // MARK: - Properties
  
  open var dimmingView: UIView = {
    let view = UIView()
    let color = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 0.4)
    if #available(iOS 11.0, *) {
      view.backgroundColor = UIColor(named: "dimmingColor") ?? color
    } else {
      view.backgroundColor = color
    }
    return view
  }()
  
  // MARK: - Override methods
  
  open override func presentationTransitionWillBegin() {
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.frame = containerView?.bounds ?? .zero
    containerView?.addSubview(dimmingView)
    
    presentedView?.frame = frameOfPresentedViewInContainerView
    containerView?.addSubview(presentedViewController.view)
    
    presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1
    }, completion: nil)
  }
  
  open override func presentationTransitionDidEnd(_ completed: Bool) {
    if !completed {
      dimmingView.removeFromSuperview()
    }
  }
  
  open override func dismissalTransitionWillBegin() {
    presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0
    }, completion: nil)
  }
  
  open override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      dimmingView.removeFromSuperview()
    }
  }
}
