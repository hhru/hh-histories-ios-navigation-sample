import UIKit

struct RoomListScreen {

    func build() -> UINavigationController {
        let viewController = RoomListViewController(authorizationProvider: DefaultAuthorizationProvider.shared)
        let stack = UINavigationController(rootViewController: viewController)

        stack.tabBarItem = .rooms

        return stack
    }
}
