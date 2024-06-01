import UIKit

/// A custom transition for presenting and dismissing view controllers modally.
open class ModalTransition: NSObject, DismissableTransition, UIViewControllerTransitioningDelegate {
    // MARK: - Properties
    
    /// The view controller from which the transition originates.
    public private(set) weak var fromViewController: UIViewController?
    
    /// The transition style to be used.
    private let transitionStyle: UIModalTransitionStyle
    
    /// The presentation style to be used.
    private let presentationStyle: UIModalPresentationStyle
    
    // MARK: - Inits
    
    /// Initializes a new modal transition instance.
    ///
    /// - Parameters:
    ///   - viewController: The view controller from which the transition originates. Default is `nil`.
    ///   - transitionStyle: The transition style to be used. Default is `.coverVertical`.
    ///   - presentationStyle: The presentation style to be used. Default is `.default`.
    public init(
        fromViewController viewController: UIViewController?,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentationStyle: UIModalPresentationStyle = .default
    ) {
        self.fromViewController = viewController
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
    }
    
    // MARK: - DismissableTransition
    
    /// Presents a view controller modally with the specified transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: A Boolean indicating whether the presentation should be animated.
    ///   - completion: An optional closure to be executed after the presentation animation completes.
    open func present(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = transitionStyle
        viewController.modalPresentationStyle = presentationStyle
        fromViewController?.present(viewController, animated: animated, completion: completion)
    }
    
    /// Dismisses a view controller modally with the specified transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to dismiss.
    ///   - animated: A Boolean indicating whether the dismissal should be animated.
    ///   - completion: An optional closure to be executed after the dismissal animation completes.
    open func dismiss(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = transitionStyle
        viewController.modalPresentationStyle = presentationStyle
        viewController.dismiss(animated: true, completion: completion)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    /// Returns the animator object that manages the transition animations when a view controller is presented.
    ///
    /// - Parameters:
    ///   - presented: The view controller object that is about to be presented onscreen.
    ///   - presenting: The view controller that is presenting the view controller in the presented parameter.
    ///   The object in this parameter could be the root view controller of the window, a parent view controller
    ///   that is marked as defining the current context, or the last view controller that was presented.
    ///   This view controller may or may not be the same as the one in the source parameter.
    ///   - source: The view controller whose `present(_:animated:completion:)` method was called.
    ///
    /// - Returns: An object conforming to the UIViewControllerAnimatedTransitioning protocol that
    /// manages the transition animations, or nil if you want to use the default system animations.
    open func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    /// Returns the animator object that manages the transition animations when a view controller is dismissed.
    ///
    /// - Parameter dismissed: The view controller object that is about to be dismissed.
    ///
    /// - Returns: An object conforming to the UIViewControllerAnimatedTransitioning protocol that
    /// manages the transition animations, or nil if you want to use the default system animations.
    open func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    /// Returns an interaction controller object if the transition should be interactive during presentation.
    ///
    /// - Parameter animator: The transition animator object returned by your
    /// `animationController(forPresented:presenting:source:)` method.
    ///
    /// - Returns: An object conforming to the UIViewControllerInteractiveTransitioning protocol
    /// that manages the interactive transition, or nil if the transition should not be interactive.
    open func interactionControllerForPresentation(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    /// Returns an interaction controller object if the transition should be interactive during dismissal.
    ///
    /// - Parameter animator: The transition animator object returned by your
    /// `animationController(forDismissed:)` method.
    ///
    /// - Returns: An object conforming to the UIViewControllerInteractiveTransitioning protocol
    /// that manages the interactive transition, or nil if the transition should not be interactive.
    open func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    /// Returns a custom presentation controller object for managing the presentation characteristics of the view controller being presented.
    ///
    /// - Parameters:
    ///   - presented: The view controller being presented.
    ///   - presenting: The view controller that is presenting the view controller in the presented parameter.
    ///   The object in this parameter could be the root view controller of the window, a parent view controller
    ///   that is marked as defining the current context, or the last view controller that was presented.
    ///   This view controller may or may not be the same as the one in the source parameter.
    ///   This parameter may also be nil to indicate that the presenting view controller will be determined later.
    ///   - source: The view controller whose `present(_:animated:completion:)`
    ///   method was called to initiate the presentation process.
    ///
    /// - Returns: A custom UIPresentationController object that manages
    /// the presentation characteristics, or nil if you want to use the default presentation behavior.
    open func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return nil
    }
}
