import UIKit
import RouteComposer

struct ProfileScreen: Factory {

    typealias ViewController = UIViewController
    typealias Context = Any?

    func build(with context: Any?) throws -> UIViewController {
        ProfileViewController()
    }
}
