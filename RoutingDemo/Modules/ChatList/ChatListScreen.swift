import UIKit

struct ChatListScreen {

    let roomID: Int

    func build() -> UIViewController {
        ChatListViewController(roomID: roomID)
    }
}
