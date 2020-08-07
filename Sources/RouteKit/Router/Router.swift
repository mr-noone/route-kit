//
//  Router.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public protocol RouterProtocol where Self: AnyObject {
  var viewController: UIViewController? { get }
  var fromTransition: TransitionProtocol? { get }
  
  init(viewController: UIViewController?, fromTransition: TransitionProtocol?)
}

open class Router: RouterProtocol {
  public private(set) weak var viewController: UIViewController?
  public private(set) var fromTransition: TransitionProtocol?
  
  public required init(viewController: UIViewController? = nil, fromTransition: TransitionProtocol? = nil) {
    self.viewController = viewController
    self.fromTransition = fromTransition
  }
}
