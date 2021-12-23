import UIKit
import RouteComposer

struct HomeScreen: ContainerFactory {

    typealias ViewController = UITabBarController
    typealias Context = Void

    let router: Router

    func build(with context: Void, integrating coordinator: ChildCoordinator<Void>) throws -> UITabBarController {
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
