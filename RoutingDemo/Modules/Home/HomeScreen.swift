import UIKit
import RouteComposer

struct HomeScreen: ContainerFactory {

    typealias ViewController = HomeTabBarController
    typealias Context = Any?

    let router: Router

    func build(with context: Any?, integrating coordinator: ChildCoordinator<Any?>) throws -> HomeTabBarController {
        let controller = HomeTabBarController()

        if !coordinator.isEmpty {
            controller.viewControllers = try coordinator.build(
                with: context,
                integrating: controller.viewControllers ?? []
            )
        }

        return controller
    }
}
