import UIKit

struct ChatListScreen {

    let roomID: Int

    func build() -> UINavigationController {
        UINavigationController(rootViewController: ChatListViewController(roomID: roomID))
    }
}
