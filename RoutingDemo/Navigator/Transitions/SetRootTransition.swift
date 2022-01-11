import UIKit

final class SetRootTransition: ViewControllerContextTransition {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(from source: UIViewController?, to destination: UIViewController, animated: Bool) {
        window.rootViewController = destination
    }
}
