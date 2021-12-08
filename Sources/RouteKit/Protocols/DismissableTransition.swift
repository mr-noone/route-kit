import UIKit

public protocol DismissableTransition where Self: PresentableTransition {
  func dismiss(_ viewController: UIViewController, animated: Bool, completion: Completion?)
}
