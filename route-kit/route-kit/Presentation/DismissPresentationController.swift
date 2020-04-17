//
//  DismissPresentationController.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 17.04.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

open class DismissPresentationController: DimmingPresentationController {
  // MARK: - Private properties
  
  private var transition: TransitionProtocol
  private lazy var dismissView: UIControl = {
    let view = UIControl()
    view.frame = containerView?.bounds ?? .zero
    view.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    return view
  }()
  
  // MARK: - Inits
  
  public init(presentedViewController: UIViewController,
              presenting presentingViewController: UIViewController?,
              transition: TransitionProtocol) {
    self.transition = transition
    super.init(presentedViewController: presentedViewController,
               presenting: presentingViewController)
  }
  
  // MARK: - Actions
  
  @objc func dismiss() {
    transition.close(presentedViewController, animated: true, completion: nil)
  }
  
  // MARK: - Override methods
  
  public override func presentationTransitionWillBegin() {
    containerView?.addSubview(dismissView)
    super.presentationTransitionWillBegin()
  }
  
  public override func presentationTransitionDidEnd(_ completed: Bool) {
    super.presentationTransitionDidEnd(completed)
    if !completed {
      dismissView.removeFromSuperview()
    }
  }
  
  public override func dismissalTransitionDidEnd(_ completed: Bool) {
    super.dismissalTransitionDidEnd(completed)
    if completed {
      dismissView.removeFromSuperview()
    }
  }
}
