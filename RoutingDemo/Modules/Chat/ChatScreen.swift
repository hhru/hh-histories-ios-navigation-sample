import UIKit
import RouteComposer

struct ChatScreen: Factory {

    typealias ViewController = ChatViewController
    typealias Context = ChatContext

    func build(with context: ChatContext) throws -> ChatViewController {
        guard let chatID = context.chatID else {
            throw RoutingError.generic(RoutingError.Context("chatID can't be nil"))
        }

        return ChatViewController(
            chatID: chatID,
            roomID: context.roomID
        )
    }
}
