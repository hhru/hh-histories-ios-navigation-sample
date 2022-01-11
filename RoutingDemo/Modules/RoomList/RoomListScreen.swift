import UIKit

struct RoomListScreen {

    let router: ViewControllerContextRouterProtocol

    func build() -> UINavigationController {
        let stack = UINavigationController(
            rootViewController: RoomListViewController(
                router: router,
                authorizationProvider: DefaultAuthorizationProvider.shared
            )
        )

        stack.tabBarItem = .rooms

        return stack
    }
}
