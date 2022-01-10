import UIKit
import RouteComposer

struct RoomListScreen: Factory {

    typealias ViewController = RoomListViewController
    typealias Context = Any?

    let router: Router

    func build(with context: Any?) throws -> RoomListViewController {
        RoomListViewController(authorizationProvider: DefaultAuthorizationProvider.shared, router: router)
    }
}
