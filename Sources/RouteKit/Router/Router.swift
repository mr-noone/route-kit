import UIKit

/// A basic implementation of the `RouterProtocol` for routing within an application.
open class Router: RouterProtocol {
    /// The current view controller associated with the router.
    public private(set) weak var viewController: UIViewController?
    
    /// The transition used to present the current view controller.
    public private(set) var fromTransition: PresentableTransition?
    
    /// Initializes a new router with the specified view controller and transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller associated with the router. Default is `nil`.
    ///   - fromTransition: The transition used to present the view controller. Default is `nil`.
    public required init(
        viewController: UIViewController? = nil,
        fromTransition: PresentableTransition? = nil
    ) {
        self.viewController = viewController
        self.fromTransition = fromTransition
    }
}
