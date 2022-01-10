import UIKit
import RouteComposer

final class MainSceneRouter {

    let router: Router
    let window: UIWindow

    init(router: Router, window: UIWindow) {
        self.router = router
        self.window = window
    }

    func showRootScreen() {
        window.rootViewController = UIViewController()

        try? router.navigate(to: Screens.homeScreen(router: router), animated: false, completion: nil)
    }

    func showChat(roomID: Int, chatID: Int) {
        try? router.navigate(
            to: Screens.chatScreen(router: router),
            with: ChatContext(roomID: roomID, chatID: chatID),
            animated: true,
            completion: nil
        )
    }
}
