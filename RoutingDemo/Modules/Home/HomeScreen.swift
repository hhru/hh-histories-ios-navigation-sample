import UIKit
import Nivelir

struct HomeScreen: Screen {

    func build(navigator: ScreenNavigator) -> UITabBarController {
        let view = HomeTabBarController()

        navigator.navigate(from: view) { route in
            route
                .setupTab(
                    with: ProfileScreen()
                        .withStackContainer()
                        .withTabBarItem(.profile)
                )
                .setupTab(
                    with: RoomListScreen()
                        .withStackContainer()
                        .withTabBarItem(.rooms)
                )
                .selectTab(with: .index(0))
        }

        return view
    }
}
