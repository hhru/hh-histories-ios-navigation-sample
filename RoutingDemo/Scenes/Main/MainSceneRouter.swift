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
        window.rootViewController = try? HomeScreen().build()
    }
}
