import UIKit

struct HomeScreen {

    let router: ViewControllerContextRouterProtocol

    func build() -> UITabBarController {
        let tabs = HomeTabBarController()

        tabs.viewControllers = [
            ProfileScreen().build(),
            RoomListScreen(router: router).build()
        ]

        return tabs
    }
}
