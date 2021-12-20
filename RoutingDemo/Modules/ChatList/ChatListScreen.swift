import UIKit

struct ChatListScreen {

    let title: String

    func build() -> UIViewController {
        ChatListViewController(title: title)
    }
}
