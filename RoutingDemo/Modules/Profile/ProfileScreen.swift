import UIKit

struct ProfileScreen {

    func build() -> UINavigationController {
        let viewController = ProfileViewController()
        let stack = UINavigationController(rootViewController: viewController)

        stack.tabBarItem = .profile

        return stack
    }
}
