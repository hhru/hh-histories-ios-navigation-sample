import UIKit

struct ChatScreen {

    let contextInfo: ChatContextInfo

    func build() -> UIViewController {
        ChatViewController(
            contextInfo: contextInfo
        )
    }
}
