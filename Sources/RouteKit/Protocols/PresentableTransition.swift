import UIKit

public protocol PresentableTransition where Self: AnyObject {
  typealias Completion = () -> ()
  func present(_ viewController: UIViewController, animated: Bool, completion: Completion?)
}
