import UIKit

struct RoomListScreen {

    let router: ViewControllerContextRouterProtocol

    func build() -> UINavigationController {
        let viewController = RoomListViewController(router: router)
        let stack = UINavigationController(rootViewController: viewController)

        stack.tabBarItem = .rooms

        return stack
    }
}
