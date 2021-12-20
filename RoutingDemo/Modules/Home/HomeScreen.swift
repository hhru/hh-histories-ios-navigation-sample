import UIKit

struct HomeScreen {

    func build() -> UITabBarController {
        let view = HomeTabBarController()

        let chatViewController = ChatListScreen(title: "Public Chats").build()
        let chatNavigationController = UINavigationController(rootViewController: chatViewController)
        chatNavigationController.tabBarItem = .publicChats

        let profileViewController = ProfileScreen().build()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = .profile

        let roomListViewController = RoomListScreen().build()
        let roomListNavigationController = UINavigationController(rootViewController: roomListViewController)
        roomListViewController.tabBarItem = .privateRooms

        view.viewControllers = [chatNavigationController, profileNavigationController, roomListNavigationController]

        return view
    }
}
