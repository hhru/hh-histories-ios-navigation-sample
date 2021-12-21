import UIKit
import Nivelir

final class ChatViewController: UIViewController, ScreenKeyedContainer {

    private let chatID: Int

    private var chatEmptyView: ChatEmptyView {
        view as! ChatEmptyView
    }

    let screenKey: ScreenKey
    let screenNavigator: ScreenNavigator

    init(chatID: Int, screenKey: ScreenKey, screenNavigator: ScreenNavigator) {
        self.chatID = chatID

        self.screenKey = screenKey
        self.screenNavigator = screenNavigator

        super.init(nibName: nil, bundle: nil)

        hidesBottomBarWhenPushed = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let chatEmptyView = ChatEmptyView()

        chatEmptyView.title = "Chat \(chatID)"

        view = chatEmptyView
    }
}

extension ChatViewController: ScreenRefreshableContainer {

    func refresh(completion: @escaping () -> Void) {
        chatEmptyView.subtitle = "You're up to date 🎉"

        completion()
    }
}
