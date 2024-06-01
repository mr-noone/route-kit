import UIKit

/// A protocol defining the requirements for routing within an application.
///
/// Types conforming to `RouterProtocol` must provide properties
/// for the current view controller and the transition used to present it.
public protocol RouterProtocol where Self: AnyObject {
    /// The current view controller associated with the router.
    var viewController: UIViewController? { get }
    
    /// The transition used to present the current view controller.
    var fromTransition: PresentableTransition? { get }
    
    /// Initializes a new router with the specified view controller and transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller associated with the router.
    ///   - fromTransition: The transition used to present the view controller.
    init(viewController: UIViewController?, fromTransition: PresentableTransition?)
}

public extension RouterProtocol {
    /// Closes the current view controller, dismissing it from the navigation stack.
    ///
    /// - Parameters:
    ///   - animated: A Boolean indicating whether the dismissal should be animated. Default is `true`.
    ///   - completion: An optional closure to be executed after the dismissal animation completes.
    func close(animated: Bool = true, completion: PresentableTransition.Completion? = nil) {
        guard let fromTransition = fromTransition as? DismissableTransition,
              let viewController = viewController
        else { return }
        fromTransition.dismiss(viewController, animated: animated, completion: completion)
    }
}
