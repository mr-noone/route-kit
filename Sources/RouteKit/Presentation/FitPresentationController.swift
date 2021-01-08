//
//  File.swift
//  route-kit
//
//  Created by Aleksey Zgurskiy on 08.01.2021.
//  Copyright © 2021 mr.noone. All rights reserved.
//

import UIKit

open class FitPresentationController: DimmingPresentationController {
  // MARK: - Properties
  
  open override var frameOfPresentedViewInContainerView: CGRect {
    let maxSize = containerView?.bounds.size ?? .zero
    let size = presentedView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? .zero
    let origin = CGPoint(x: (maxSize.width - size.width) / 2,
                         y: (maxSize.height - size.height) / 2)
    return .init(origin: origin, size: size)
  }
}
