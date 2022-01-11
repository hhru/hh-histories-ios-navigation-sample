import UIKit

final class SetupTabTransition: ViewControllerContextTransition {

    func navigate(from source: UIViewController?, to destination: UIViewController, animated: Bool) {
        guard let tabBarViewController = source as? UITabBarController else {
            return assertionFailure("Attempting to setup tab to tab bar controller without having it")
        }

        let tabs = tabBarViewController.viewControllers ?? []

        tabBarViewController.viewControllers = tabs + [destination]
    }
}
