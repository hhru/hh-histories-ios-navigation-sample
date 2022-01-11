import UIKit

struct ChatListScreen {

    let roomID: Int
    let router: ViewControllerContextRouterProtocol

    func build() -> UINavigationController {
        UINavigationController(rootViewController: ChatListViewController(roomID: roomID, router: router))
    }
}
