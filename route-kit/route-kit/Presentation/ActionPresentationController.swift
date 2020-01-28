//
//  ActionPresentationController.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 28.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public final class ActionPresentationController: DimmingPresentationController {
  // MARK: - Private properties
  
  private var transition: TransitionProtocol
  private lazy var dismissView: UIControl = {
    let view = UIControl()
    view.frame = containerView?.bounds ?? .zero
    view.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    return view
  }()
  
  // MARK: - Override properties
  
  public override var frameOfPresentedViewInContainerView: CGRect {
    let maxSize = containerView?.bounds.size ?? .zero
    let targetSize = CGSize(width: maxSize.width - 28, height: 0)
    
    let size = presentedView?.systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    ) ?? .zero
    
    let insets: UIEdgeInsets
    if #available(iOS 11.0, *) {
      insets = containerView?.safeAreaInsets ?? .zero
    } else {
      insets = .zero
    }
    
    let origin = CGPoint(x: 14, y: maxSize.height - size.height - 14 - insets.bottom)
    return .init(origin: origin, size: size)
  }
  
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
