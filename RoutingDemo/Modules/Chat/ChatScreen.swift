import UIKit
import RouteComposer

struct ChatScreen: Factory {

    typealias ViewController = ChatViewController
    typealias Context = Int

    func build(with chatID: Int) throws -> ChatViewController {
        ChatViewController(
            chatID: chatID
        )
    }
}
