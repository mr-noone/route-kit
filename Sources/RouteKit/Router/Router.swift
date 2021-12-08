import UIKit

open class Router: RouterProtocol {
  public private(set) weak var viewController: UIViewController?
  public private(set) var fromTransition: PresentableTransition?
  
  public required init(viewController: UIViewController? = nil, fromTransition: PresentableTransition? = nil) {
    self.viewController = viewController
    self.fromTransition = fromTransition
  }
}
