import UIKit

final class PushStackTranition: ViewControllerContextTransition {

    func navigate(from source: UIViewController?, to destination: UIViewController, animated: Bool) {
        guard let navigationController = source?.navigationController else {
            assertionFailure("Attempting to push to navigation controller without having it")
            return
        }

        navigationController.pushViewController(destination, animated: animated)
    }
}
