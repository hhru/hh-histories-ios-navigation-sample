import UIKit

final class PresentModalTransition: ViewControllerContextTransition {

    func navigate(from source: UIViewController?, to destination: UIViewController, animated: Bool) {
        source?.present(destination, animated: animated, completion: nil)
    }
}
