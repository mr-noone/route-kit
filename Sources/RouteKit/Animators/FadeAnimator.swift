//
//  FadeAnimator.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public final class FadeAnimator: NSObject, Animator {
  // MARK: - Public properties
  
  public var isPresenting: Bool = true
  
  // MARK: - Private properties
  
  private let duration: TimeInterval
  private let options: UIView.AnimationOptions
  
  // MARK: - Inits
  
  public init(duration: TimeInterval = 0.3, options: UIView.AnimationOptions = .curveEaseOut) {
    self.duration = duration
    self.options = options
  }
  
  // MARK: - UIViewControllerAnimatedTransitioning
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromView = transitionContext.view(forKey: .from),
      let toView = transitionContext.view(forKey: .to)
    else { return }
    
    let container = transitionContext.containerView
    if isPresenting {
      container.addSubview(toView)
      toView.alpha = 0.0
    } else {
      container.insertSubview(toView, belowSubview: fromView)
    }
    
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      if self.isPresenting {
        toView.alpha = 1.0
      } else {
        fromView.alpha = 0.0
      }
    }, completion: { _ in
      let success = !transitionContext.transitionWasCancelled
      if !success {
        toView.removeFromSuperview()
      }
      transitionContext.completeTransition(success)
    })
  }
}
