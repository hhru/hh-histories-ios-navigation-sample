import UIKit
import RouteComposer

struct ChatListScreen: Factory {

    typealias ViewController = ChatListViewController
    typealias Context = Int

    let router: Router

    func build(with roomID: Int) throws -> ChatListViewController {
        ChatListViewController(roomID: roomID, router: router)
    }
}
