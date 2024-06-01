import UIKit

/// Extension for `UIModalPresentationStyle` providing a default presentation style
///
/// This extension adds a computed property `default` to `UIModalPresentationStyle`,
/// which returns the appropriate default presentation style based on the iOS version.
public extension UIModalPresentationStyle {
    /// Returns the default modal presentation style based on the iOS version.
    ///
    /// - Returns: The default modal presentation style.
    ///
    /// If the device is running iOS 13 or later, it returns `.automatic`. Otherwise, it returns `.fullScreen`.
    static var `default`: UIModalPresentationStyle {
        if #available(iOS 13.0, *) {
            return .automatic
        } else {
            return .fullScreen
        }
    }
}
