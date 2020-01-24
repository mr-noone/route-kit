//
//  Transition.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public protocol TransitionProtocol: AnyObject {
  typealias Completion = () -> ()
  
  func open(_ viewController: UIViewController, animated: Bool, completion: Completion?)
  func close(_ viewController: UIViewController, animated: Bool, completion: Completion?)
}

open class Transition: NSObject, TransitionProtocol {
  public private(set) weak var fromViewController: UIViewController?
  public private(set) var animator: Animator?
  
  public init(fromViewController: UIViewController?, animator: Animator? = nil) {
    self.fromViewController = fromViewController
    self.animator = animator
  }
  
  open func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    fatalError("This is abstract method")
  }
  
  open func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    fatalError("This is abstract method")
  }
}
