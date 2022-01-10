import UIKit
import RouteComposer

struct ChatListScreen: Factory {

    typealias ViewController = ChatListViewController
    typealias Context = Int

    func build(with roomID: Int) throws -> ChatListViewController {
        ChatListViewController(roomID: roomID)
    }
}
