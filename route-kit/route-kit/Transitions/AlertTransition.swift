//
//  AlertTransition.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 28.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public final class AlertTransition: ModalTransition {
  // MARK: - Inits
  
  public init(fromViewController: UIViewController?) {
    super.init(fromViewController: fromViewController, transitionStyle: .crossDissolve, presentationStyle: .custom)
  }
  
  // MARK: - UIViewControllerTransitioningDelegate
  
  public override func presentationController(forPresented presented: UIViewController,
                                     presenting: UIViewController?,
                                     source: UIViewController) -> UIPresentationController? {
    return AlertPresentationController(presentedViewController: presented, presenting: presenting)
  }
}
