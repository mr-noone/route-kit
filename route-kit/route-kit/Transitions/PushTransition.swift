//
//  PushTransition.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public final class PushTransition: Transition {
  // MARK: - Properties
  
  fileprivate var completion: Completion?
  private var navigation: UINavigationController? {
    return fromViewController?.navigationController
  }
  
  // MARK: - Inits
  
  public override init(fromViewController: UIViewController?, animator: Animator? = nil) {
    super.init(fromViewController: fromViewController, animator: animator)
    navigation?.delegate = NavigationDelegate.default
    NavigationDelegate.default.addTransition(self)
  }
  
  // MARK: - Transition methods
  
  public override func open(_ viewController: UIViewController, animated: Bool, completion: Transition.Completion?) {
    self.completion = completion
    navigation?.pushViewController(viewController, animated: animated)
  }
  
  public override func close(_ viewController: UIViewController, animated: Bool, completion: Transition.Completion?) {
    self.completion = completion
    navigation?.popViewController(animated: animated)
  }
}

private final class NavigationDelegate: NSObject, UINavigationControllerDelegate {
  // MARK: - Properties
  
  static let `default` = NavigationDelegate()
  private let transitions = NSPointerArray.weakObjects()
  private var currentTransition: PushTransition? {
    return transitions.allObjects.last as? PushTransition
  }
  
  // MARK: - Methods
  
  func addTransition(_ transition: PushTransition) {
    transitions.addPointer(Unmanaged.passUnretained(transition).toOpaque())
  }
  
  // MARK: - UINavigationControllerDelegate
  
  public func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    currentTransition?.completion?()
  }
  
  public func navigationController(_ navigationController: UINavigationController,
                                   animationControllerFor operation: UINavigationController.Operation,
                                   from fromVC: UIViewController,
                                   to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    currentTransition?.animator?.isPresenting = operation == .push
    return currentTransition?.animator
  }
}
