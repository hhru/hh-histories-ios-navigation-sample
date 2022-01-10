import UIKit
import RouteComposer

struct ChatListScreen: Factory {

    typealias ViewController = ChatListViewController
    typealias Context = ChatContext

    let router: Router

    func build(with context: ChatContext) throws -> ChatListViewController {
        ChatListViewController(roomID: context.roomID, router: router)
    }
}
