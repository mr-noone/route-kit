import UIKit

/// A protocol defining the requirements for presenting view controllers.
///
/// Types conforming to `PresentableTransition` must implement the
/// `present(_:animated:completion:)` method, which allows for presenting a `UIViewController`.
public protocol PresentableTransition where Self: AnyObject {
    /// A typealias representing a closure to be executed upon completion of the presentation.
    typealias Completion = () -> ()
    
    /// Presents a view controller using the specified transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: A Boolean indicating whether the presentation should be animated.
    ///   - completion: An optional closure to be executed after the presentation animation completes.
    func present(_ viewController: UIViewController, animated: Bool, completion: Completion?)
}
