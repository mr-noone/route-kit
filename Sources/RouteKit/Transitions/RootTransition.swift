//
//  RootTransition.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 28.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public class RootTransition: TransitionProtocol {
  // MARK: - Properties
  
  private weak var window: UIWindow?
  private let options: UIView.AnimationOptions
  private let duration: TimeInterval
  
  // MARK: - Inits
  
  public init(window: UIWindow, options: UIView.AnimationOptions = .transitionCrossDissolve, duration: TimeInterval = 0.2) {
    self.window = window
    self.options = options
    self.duration = duration
  }
  
  // MARK: - Transition methods
  
  public func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    guard let window = window else { fatalError("Window is nil") }
    window.rootViewController = viewController
    if animated {
      UIView.transition(with: window, duration: duration, options: options, animations: nil) { _ in completion?() }
    } else {
      completion?()
    }
  }
  
  @available(*, deprecated)
  public func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    fatalError()
  }
}
