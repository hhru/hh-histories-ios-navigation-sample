import UIKit
import RouteComposer

class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: MainSceneRouter?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let router = MainSceneRouter(router: DefaultRouter(), window: window)

        self.window = window
        self.router = router

        router.showRootScreen()
        window.makeKeyAndVisible()
    }
}
