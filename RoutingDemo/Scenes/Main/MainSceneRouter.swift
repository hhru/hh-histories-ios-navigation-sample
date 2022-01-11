import UIKit

final class MainSceneRouter {

    let router: ViewControllerContextRouterProtocol

    init(router: ViewControllerContextRouterProtocol) {
        self.router = router
    }

    func showRootScreen() {
        router.navigateToScreen(.home, animated: false)
        router.navigateToScreen(.profile, animated: false)
        router.navigateToScreen(.roomList, animated: false)
    }
}
