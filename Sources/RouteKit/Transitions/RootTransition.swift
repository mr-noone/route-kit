import UIKit

/// A class responsible for transitioning the root view controller of a `UIWindow`.
public final class RootTransition: NSObject, PresentableTransition {
    // MARK: - Properties
    
    /// The window in which the root view controller transition will occur.
    private weak var window: UIWindow?
    
    /// The animation options to be applied during the transition.
    private let options: UIView.AnimationOptions
    
    /// The duration of the transition animation.
    private let duration: TimeInterval
    
    // MARK: - Inits
    
    /// Initializes a `RootTransition` instance.
    ///
    /// - Parameters:
    ///   - window: The window in which the transition will take place.
    ///   - options: The animation options to be applied. Defaults to `.transitionCrossDissolve`.
    ///   - duration: The duration of the transition animation. Defaults to `0.2` seconds.
    public init(
        window: UIWindow,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        duration: TimeInterval = 0.2
    ) {
        self.window = window
        self.options = options
        self.duration = duration
    }
    
    // MARK: - PresentableTransition
    
    /// Presents a view controller as the root view controller of the window.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to be presented as the new root.
    ///   - animated: A Boolean value indicating whether the transition should be animated.
    ///   - completion: A closure to be executed after the transition completes. Defaults to `nil`.
    public func present(
        _ viewController: UIViewController,
        animated: Bool,
        completion: Completion?
    ) {
        guard let window = window else { return }
        window.rootViewController = viewController
        if animated {
            UIView.transition(
                with: window,
                duration: duration,
                options: options,
                animations: nil
            ) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}
