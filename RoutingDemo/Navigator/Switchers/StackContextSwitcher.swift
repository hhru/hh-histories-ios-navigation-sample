import UIKit

final class StackContextSwitcher: ViewControllerContextSwitcher {

    private let topViewControllerProvider: TopViewControllerProvider

    private var topNavigationController: UINavigationController? {
        let topController = topViewControllerProvider.topViewController

        return (topController as? UINavigationController) ?? topController?.navigationController
    }

    init(topViewControllerProvider: TopViewControllerProvider) {
        self.topViewControllerProvider = topViewControllerProvider
    }

    func canSwitch(to context: ViewControllerContext) -> Bool {
        controllerInStack(with: context) != nil
    }

    func switchContext(to context: ViewControllerContext, animated: Bool) {
        guard let controllerToPop = controllerInStack(with: context) else {
            return
        }

        topNavigationController?.popToViewController(controllerToPop, animated: animated)
    }

    private func controllerInStack(with context: ViewControllerContext) -> UIViewController? {
        guard let navigationController = topNavigationController else {
            return nil
        }

        return navigationController.viewControllers.first { controller in
            guard let controller = controller as? ViewControllerContextHolder else {
                return false
            }

            return controller.currentContext == context
        }
    }
}
