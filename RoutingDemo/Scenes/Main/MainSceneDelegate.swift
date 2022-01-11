import UIKit

class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: MainSceneRouter?

    private func setupWindow(scene: UIScene) {
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

        let sceneRouter = MainSceneRouter(router: router, authorizationProvider: DefaultAuthorizationProvider.shared)

        screenFactory.router = router

        self.window = window
        self.router = sceneRouter

        window.makeKeyAndVisible()
        sceneRouter.showRootScreen()
    }

    private func setupUserNotificationCenter() {
        let center = UNUserNotificationCenter.current()

        center.delegate = self

        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("requestAuthorization() -> granted: \(granted)")
            print("requestAuthorization() -> error: \(error as Any)")
        }
    }

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        setupWindow(scene: scene)
        setupUserNotificationCenter()
    }
}

extension MainSceneDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        defer {
            completionHandler()
        }

        let userInfo = response.notification.request.content.userInfo

        guard let roomID = userInfo["room_id"] as? Int, let chatID = userInfo["chat_id"] as? Int else {
            return
        }

        router?.showChat(roomID: roomID, chatID: chatID)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .badge, .sound])
    }
}
