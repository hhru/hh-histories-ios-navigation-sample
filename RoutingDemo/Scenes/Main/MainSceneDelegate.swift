import UIKit

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
        let screenFactory = ScreenFactory()
        let tabsContextSwitcher = TabsContextSwitcher(window: window)
        let stackContextSwitcher = StackContextSwitcher(topViewControllerProvider: DefaultTopViewControllerProvider())

        let router = ViewControllerContextRouter(
            topViewControllerProvider: DefaultTopViewControllerProvider(),
            viewControllersFactory: screenFactory,
            transitionProvider: ScreenTransitionProvider(window: window),
            contextSwitchers: [tabsContextSwitcher, stackContextSwitcher]
        )

        let sceneRouter = MainSceneRouter(router: router)

        screenFactory.router = router

        self.window = window
        self.router = sceneRouter

        window.makeKeyAndVisible()
        sceneRouter.showRootScreen()
    }
}
