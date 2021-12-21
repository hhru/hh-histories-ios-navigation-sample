import UIKit
import Nivelir

struct RoomListScreen: Screen {

    func build(navigator: ScreenNavigator) -> UIViewController {
        RoomListViewController(
            authorizationProvider: DefaultAuthorizationProvider.shared,
            screenKey: key,
            screenNavigator: navigator
        )
    }
}
