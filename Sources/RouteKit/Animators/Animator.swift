//
//  Animator.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 24.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public protocol Animator where Self: NSObject, Self: UIViewControllerAnimatedTransitioning {
  var isPresenting: Bool { get set }
}
