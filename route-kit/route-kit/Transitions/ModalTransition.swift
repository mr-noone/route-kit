//
//  ModalTransition.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public extension UIModalPresentationStyle {
  static var `default`: UIModalPresentationStyle {
    if #available(iOS 13.0, *) {
      return .automatic
    } else {
      return .fullScreen
    }
  }
}

open class ModalTransition: Transition, UIViewControllerTransitioningDelegate {
  // MARK: - Properties
  
  private let transitionStyle: UIModalTransitionStyle
  private let presentationStyle: UIModalPresentationStyle
  
  // MARK: - Inits
  
  public init(fromViewController: UIViewController?,
              transitionStyle: UIModalTransitionStyle = .coverVertical,
              presentationStyle: UIModalPresentationStyle = .default) {
    self.transitionStyle = transitionStyle
    self.presentationStyle = presentationStyle
    super.init(fromViewController: fromViewController)
  }
  
  public override init(fromViewController: UIViewController?, animator: Animator? = nil) {
    self.transitionStyle = .coverVertical
    self.presentationStyle = .default
    super.init(fromViewController: fromViewController, animator: animator)
  }
  
  // MARK: - Transition methods
  
  public override func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    viewController.transitioningDelegate = self
    viewController.modalTransitionStyle = transitionStyle
    viewController.modalPresentationStyle = presentationStyle
    fromViewController?.present(viewController, animated: animated, completion: completion)
  }
  
  public override func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    viewController.dismiss(animated: animated, completion: completion)
  }
  
  // MARK: - UIViewControllerTransitioningDelegate
  
  open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.isPresenting = true
    return animator
  }
  
  open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.isPresenting = false
    return animator
  }
  
  open func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return nil
  }
}
