import UIKit
import Nivelir

struct ChatListScreen: Screen {

    let title: String

    func build(navigator: ScreenNavigator) -> UIViewController {
        ChatListViewController(
            title: title,
            screenKey: key,
            screenNavigator: navigator
        )
    }
}
