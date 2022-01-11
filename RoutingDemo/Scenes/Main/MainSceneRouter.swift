import UIKit

final class MainSceneRouter {

    let router: ViewControllerContextRouterProtocol

    init(router: ViewControllerContextRouterProtocol) {
        self.router = router
    }

    func showRootScreen() {
        router.navigateToScreen(.home, animated: false)
    }
}
