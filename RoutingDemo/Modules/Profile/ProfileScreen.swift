import UIKit
import RouteComposer

struct ProfileScreen: Factory {

    typealias ViewController = UIViewController
    typealias Context = Void

    func build(with context: Void) throws -> UIViewController {
        ProfileViewController()
    }
}
