import UIKit

struct ChatScreen {

    let chatID: Int

    func build() -> UIViewController {
        ChatViewController(
            chatID: chatID
        )
    }
}
