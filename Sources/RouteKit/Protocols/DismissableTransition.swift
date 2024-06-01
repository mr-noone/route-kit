import UIKit

/// A protocol defining the requirements for dismissing view controllers.
///
/// Types conforming to `DismissableTransition` must also conform to `PresentableTransition`
/// and implement the `dismiss(_:animated:completion:)` method to dismiss a `UIViewController`.
public protocol DismissableTransition where Self: PresentableTransition {
    /// Dismisses a view controller using the specified transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to dismiss.
    ///   - animated: A Boolean indicating whether the dismissal should be animated.
    ///   - completion: An optional closure to be executed after the dismissal animation completes.
    func dismiss(_ viewController: UIViewController, animated: Bool, completion: Completion?)
}
