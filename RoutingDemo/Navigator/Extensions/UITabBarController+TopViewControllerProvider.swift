import UIKit

extension UITabBarController: TopViewControllerProvider {

    var topViewController: UIViewController? {
        selectedViewController
    }
}
