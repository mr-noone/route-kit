import UIKit

/// A custom transition for presenting and dismissing view controllers within a navigation controller.
open class PushTransition: NSObject, DismissableTransition {
    // MARK: - Properties
    
    /// The navigation controller associated with the transition.
    public private(set) weak var navigationController: UINavigationController?
    
    /// The completion closure for the transition.
    private var completion: Completion?
    
    /// The number of view controllers to remove from the navigation stack when pushing a new view controller.
    private let popCount: Int
    
    /// Initializes a new push transition instance.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller associated with the transition.
    ///   - popCount: The number of view controllers to remove from the navigation stack when pushing a new view controller. Default is 0.
    public init(navigationController: UINavigationController?, popCount: Int = 0) {
        self.navigationController = navigationController
        self.popCount = popCount
        
        super.init()
        
        self.navigationController?.delegate = NavigationDelegate.default
        self.navigationController?.interactivePopGestureRecognizer?.delegate = NavigationDelegate.default
        NavigationDelegate.default.addTransition(self)
    }
    
    // MARK: - DismissableTransition
    
    /// Presents a view controller using push transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: A Boolean value indicating whether the transition should be animated.
    ///   - completion: The completion closure to be called after the transition finishes.
    open func present(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
        self.completion = completion
        switch popCount {
        case 0:
            navigationController?.pushViewController(viewController, animated: animated)
        default:
            let vcCount = navigationController?.viewControllers.count ?? 0
            let vcSlice = navigationController?.viewControllers[0..<(vcCount - popCount)] ?? []
            let vcArray = Array(vcSlice) + [viewController]
            navigationController?.setViewControllers(vcArray, animated: animated)
        }
    }
    
    /// Dismisses a view controller using pop transition.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to dismiss.
    ///   - animated: A Boolean value indicating whether the transition should be animated.
    ///   - completion: The completion closure to be called after the transition finishes.
    open func dismiss(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
        self.completion = completion
        navigationController?.popViewController(animated: animated)
    }
    
    // MARK: - Methods
    
    /// Determines whether the interactive pop gesture recognizer should begin.
    ///
    /// This method evaluates whether the interactive pop gesture recognizer should begin recognizing gestures.
    /// It checks the current state of the navigation stack to decide if the user can navigate back from the current view controller.
    ///
    /// By default, the implementation checks the number of view controllers in the navigation stack (`viewControllers` array of the navigation controller).
    /// If there is only one view controller in the stack, the gesture recognizer will be prevented from recognizing gestures to navigate back.
    ///
    /// - Parameter gestureRecognizer: The gesture recognizer instance associated with the interactive pop gesture.
    /// - Returns: `true` if the gesture recognizer should recognize gestures; `false` if gestures should be prevented.
    open func interactivePopGestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        navigationController?.viewControllers.count ?? 0 > 1
    }
    
    /// Notifies the completion closure after a view controller is shown.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - viewController: The view controller that was shown.
    ///   - animated: A Boolean value indicating whether the transition was animated.
    fileprivate func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        completion?()
        completion = nil
    }
    
    /// Provides an interactive transition object for the navigation controller.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - animationController: The animation controller for the transition.
    ///
    /// - Returns: An interactive transition object if available, otherwise nil.
    open func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        nil
    }
    
    /// Provides an animation controller for the navigation controller.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - operation: The navigation operation (push or pop).
    ///   - fromVC: The source view controller.
    ///   - toVC: The destination view controller.
    ///
    /// - Returns: An animation controller for the specified operation.
    open func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        nil
    }
}

/// A private class that acts as the delegate for navigation controller transitions.
private final class NavigationDelegate: NSObject, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    // MARK: - Properties
    
    /// The default shared instance of the NavigationDelegate.
    static let `default` = NavigationDelegate()
    
    /// An array to hold weak references to PushTransition instances.
    private let transitions = NSPointerArray.weakObjects()
    
    /// Retrieves the current transition from the transitions array.
    private var currentTransition: PushTransition? {
        transitions.allObjects.last as? PushTransition
    }
    
    // MARK: - Methods
    
    /// Adds a PushTransition instance to the transitions array.
    ///
    /// - Parameter transition: The PushTransition instance to add.
    func addTransition(_ transition: PushTransition) {
        transitions.addPointer(Unmanaged.passUnretained(transition).toOpaque())
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    /// Determines whether the interactive gesture recognizer should begin.
    ///
    /// - Parameter gestureRecognizer: The gesture recognizer to check.
    ///
    /// - Returns: A Boolean value indicating whether the gesture should begin.
    func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        currentTransition?.interactivePopGestureRecognizerShouldBegin(
            gestureRecognizer
        ) ?? true
    }
    
    // MARK: - UINavigationControllerDelegate
    
    /// Notifies the current transition after a view controller is shown.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - viewController: The view controller that was shown.
    ///   - animated: A Boolean value indicating whether the transition was animated.
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        currentTransition?.navigationController(
            navigationController,
            didShow: viewController,
            animated: animated
        )
    }
    
    /// Provides an interactive transition object for the navigation controller.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - animationController: The animation controller for the transition.
    ///
    /// - Returns: An interactive transition object if available, otherwise nil.
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        currentTransition?.navigationController(
            navigationController,
            interactionControllerFor: animationController
        )
    }
    
    /// Provides an animation controller for the navigation controller.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller.
    ///   - operation: The navigation operation (push or pop).
    ///   - fromVC: The source view controller.
    ///   - toVC: The destination view controller.
    ///
    /// - Returns: An animation controller for the specified operation.
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        currentTransition?.navigationController(
            navigationController,
            animationControllerFor: operation,
            from: fromVC,
            to: toVC
        )
    }
}
