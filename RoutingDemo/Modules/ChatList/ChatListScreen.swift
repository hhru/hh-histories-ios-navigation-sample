import UIKit
import Nivelir

struct ChatListScreen: Screen {

    let roomID: Int

    func build(navigator: ScreenNavigator) -> UIViewController {
        ChatListViewController(
            roomID: roomID,
            screenKey: key,
            screenNavigator: navigator
        )
    }
}
