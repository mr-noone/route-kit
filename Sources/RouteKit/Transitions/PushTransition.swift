import UIKit

open class PushTransition: NSObject, DismissableTransition {
  // MARK: - Properties
  
  public private(set) weak var navigationController: UINavigationController?
  private var completion: Completion?
  private let popCount: Int
  
  // MARK: - Inits
  
  public init(navigationController: UINavigationController?, popCount: Int = 0) {
    self.navigationController = navigationController
    self.popCount = popCount
    
    super.init()
    
    self.navigationController?.delegate = NavigationDelegate.default
    self.navigationController?.interactivePopGestureRecognizer?.delegate = NavigationDelegate.default
    NavigationDelegate.default.addTransition(self)
  }
  
  // MARK: - DismissableTransition
  
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
  
  open func dismiss(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
    self.completion = completion
    navigationController?.popViewController(animated: animated)
  }
  
  // MARK: - Methods
  
  open func interactivePopGestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return navigationController?.viewControllers.count ?? 0 > 1
  }
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    completion?()
    completion = nil
  }
  
  open func navigationController(
    _ navigationController: UINavigationController,
    interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
  ) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }
  
  open func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return nil
  }
}

private final class NavigationDelegate: NSObject, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  // MARK: - Properties
  
  static let `default` = NavigationDelegate()
  
  private let transitions = NSPointerArray.weakObjects()
  private var currentTransition: PushTransition? {
    return transitions.allObjects.last as? PushTransition
  }
  
  // MARK: - Methods
  
  func addTransition(_ transition: PushTransition) {
    transitions.addPointer(Unmanaged.passUnretained(transition).toOpaque())
  }
  
  // MARK: - UIGestureRecognizerDelegate
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return currentTransition?.interactivePopGestureRecognizerShouldBegin(gestureRecognizer) ?? true
  }
  
  // MARK: - UINavigationControllerDelegate
  
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
  
  func navigationController(
    _ navigationController: UINavigationController,
    interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
  ) -> UIViewControllerInteractiveTransitioning? {
    return currentTransition?.navigationController(
      navigationController,
      interactionControllerFor: animationController
    )
  }
  
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return currentTransition?.navigationController(
      navigationController,
      animationControllerFor: operation,
      from: fromVC,
      to: toVC
    )
  }
}
