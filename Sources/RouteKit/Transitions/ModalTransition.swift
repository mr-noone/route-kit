import UIKit

open class ModalTransition<From: UIViewController, To: UIViewController>: NSObject, DismissableTransition, UIViewControllerTransitioningDelegate {
  // MARK: - Properties
  
  public private(set) weak var fromViewController: From?
  private let transitionStyle: UIModalTransitionStyle
  private let presentationStyle: UIModalPresentationStyle
  
  // MARK: - Inits
  
  public init(fromViewController viewController: From?,
              transitionStyle: UIModalTransitionStyle = .coverVertical,
              presentationStyle: UIModalPresentationStyle = .default) {
    self.fromViewController = viewController
    self.transitionStyle = transitionStyle
    self.presentationStyle = presentationStyle
  }
  
  // MARK: - DismissableTransition
  
  public func present(_ viewController: To, animated: Bool, completion: Completion?) {
    viewController.transitioningDelegate = self
    viewController.modalTransitionStyle = transitionStyle
    viewController.modalPresentationStyle = presentationStyle
    fromViewController?.present(viewController, animated: animated, completion: completion)
  }
  
  public func dismiss(_ viewController: To, animated: Bool, completion: Completion?) {
    viewController.transitioningDelegate = self
    viewController.modalTransitionStyle = transitionStyle
    viewController.modalPresentationStyle = presentationStyle
    viewController.dismiss(animated: true, completion: completion)
  }
  
  // MARK: - UIViewControllerTransitioningDelegate
  
  open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return nil
  }
  
  open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return nil
  }
  
  open func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return nil
  }
}
