import UIKit

final class ChatViewController: UIViewController {

    let chatID: Int

    init(chatID: Int) {
        self.chatID = chatID

        super.init(nibName: nil, bundle: nil)

        #if os(iOS)
        hidesBottomBarWhenPushed = true
        #endif
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
