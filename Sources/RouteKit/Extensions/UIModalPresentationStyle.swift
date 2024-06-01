import UIKit

public extension UIModalPresentationStyle {
    static var `default`: UIModalPresentationStyle {
        if #available(iOS 13.0, *) {
            return .automatic
        } else {
            return .fullScreen
        }
    }
}
