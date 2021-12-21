import UIKit
import Nivelir

struct HomeScreen: Screen {

    func build(navigator: ScreenNavigator) -> UITabBarController {
        let view = HomeTabBarController()

        let profileViewController = ProfileScreen().build()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = .profile

        let roomListViewController = RoomListScreen().build()
        let roomListNavigationController = UINavigationController(rootViewController: roomListViewController)
        roomListViewController.tabBarItem = .rooms

        view.viewControllers = [profileNavigationController, roomListNavigationController]

        return view
    }
}
