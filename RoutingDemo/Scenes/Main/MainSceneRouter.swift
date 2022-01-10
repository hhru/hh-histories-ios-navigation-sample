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

        let tabStep = StepAssembly(
            finder: ClassFinder(),
            factory: CompleteFactoryAssembly(factory: HomeScreen(router: router))
                .with(
                    CompleteFactoryAssembly(
                        factory: NavigationControllerFactory<UINavigationController, Void>(
                            configuration: { navigationController in
                                navigationController.tabBarItem = .profile
                            }
                        )
                    ).with(ProfileScreen()).assemble(),
                    using: UITabBarController.add()
                )
                .with(
                    CompleteFactoryAssembly(
                        factory: NavigationControllerFactory<UINavigationController, Void>(
                            configuration: { navigationController in
                                navigationController.tabBarItem = .rooms
                            }
                        )
                    ).with(RoomListScreen(router: router)).assemble(),
                    using: UITabBarController.add()
                )
                .assemble())
            .using(GeneralAction.replaceRoot())
            .from(GeneralStep.root())
            .assemble()

        try? router.navigate(to: tabStep, animated: false, completion: nil)
    }
}
