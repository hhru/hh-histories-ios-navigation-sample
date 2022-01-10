import UIKit
import RouteComposer

struct RoomListScreen: Factory {

    typealias ViewController = UIViewController
    typealias Context = Void

    let router: Router

    func build(with context: Void) throws -> UIViewController {
        RoomListViewController(authorizationProvider: DefaultAuthorizationProvider.shared, router: router)
    }
}
