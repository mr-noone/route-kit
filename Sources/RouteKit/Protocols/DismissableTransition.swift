import UIKit

public protocol DismissableTransition where Self: PresentableTransition {
  func dismiss(_ viewController: ViewController, animated: Bool, completion: Completion?)
}
