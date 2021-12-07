import UIKit

public protocol PresentableTransition where Self: AnyObject {
  typealias Completion = () -> ()
  associatedtype ViewController: UIViewController
  func present(_ viewController: ViewController, animated: Bool, completion: Completion?)
}
