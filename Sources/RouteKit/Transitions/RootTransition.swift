import UIKit

public final class RootTransition: NSObject, PresentableTransition {
    // MARK: - Properties
    
    private weak var window: UIWindow?
    private let options: UIView.AnimationOptions
    private let duration: TimeInterval
    
    // MARK: - Inits
    
    public init(window: UIWindow,
                options: UIView.AnimationOptions = .transitionCrossDissolve,
                duration: TimeInterval = 0.2) {
        self.window = window
        self.options = options
        self.duration = duration
    }
    
    // MARK: - PresentableTransition
    
    public func present(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
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
