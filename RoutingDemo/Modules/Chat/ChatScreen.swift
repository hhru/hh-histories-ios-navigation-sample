import UIKit
import Nivelir

struct ChatScreen: Screen {

    let chatID: Int

    func build(navigator: ScreenNavigator) -> UIViewController {
        ChatViewController(
            chatID: chatID,
            screenKey: key,
            screenNavigator: navigator
        )
    }
}
