//
//  CloseRoute.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public protocol CloseRoute where Self: RouterProtocol {
  func close(_ completion: Transition.Completion?)
}

public extension CloseRoute {
  func close(_ completion: Transition.Completion? = nil) {
    guard let fromTransition = fromTransition else {
      fatalError("You should specify an open transition in order to close a module.")
    }
    
    guard let viewController = viewController else {
      fatalError("Nothing to close.")
    }
    
    fromTransition.close(viewController, animated: true, completion: completion)
  }
}
