//
//  AlertPresentationController.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 28.01.2020.
//  Copyright © 2020 mr.noone. All rights reserved.
//

import UIKit

public final class AlertPresentationController: DimmingPresentationController {
  // MARK: - Override properties
  
  public override var frameOfPresentedViewInContainerView: CGRect {
    let maxSize = containerView?.bounds.size ?? .zero
    let size = presentedView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? .zero
    let origin = CGPoint(x: (maxSize.width - size.width) / 2,
                         y: (maxSize.height - size.height) / 2)
    return .init(origin: origin, size: size)
  }
}
