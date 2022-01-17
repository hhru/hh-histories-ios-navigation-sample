import UIKit
import Nivelir

final class MainSceneRouter {

    let navigator: ScreenNavigator

    init(navigator: ScreenNavigator) {
        self.navigator = navigator
    }

    func showRootScreen() {
        navigator.navigate { route in
            route.setRoot(to: HomeScreen())
        }
    }

    func showChat(roomID: Int, chatID: Int) {
        print("showChat(roomID: \(roomID)), chatID: \(chatID))")

        navigator.navigate(to: Routes.chatRoute(roomID: roomID, chatID: chatID))
    }
}
