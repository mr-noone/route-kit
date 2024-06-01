import UIKit

public protocol RouterProtocol where Self: AnyObject {
    var viewController: UIViewController? { get }
    var fromTransition: PresentableTransition? { get }
    init(viewController: UIViewController?, fromTransition: PresentableTransition?)
}

public extension RouterProtocol {
    func close(animated: Bool = true, completion: PresentableTransition.Completion? = nil) {
        guard let fromTransition = fromTransition as? DismissableTransition,
              let viewController = viewController
        else { return }
        fromTransition.dismiss(viewController, animated: animated, completion: completion)
    }
}
