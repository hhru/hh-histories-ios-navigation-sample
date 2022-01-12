import UIKit

final class ChatViewController: UIViewController {

    private let chatID: Int

    private var chatEmptyView: ChatEmptyView {
        view as! ChatEmptyView
    }

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

// MARK: - ViewControllerContextHolder

extension ChatViewController: ViewControllerContextHolder {

    var currentContext: ViewControllerContext? {
        ViewControllerContext(screenType: .chat, info: chatID)
    }
}

// MARK: - RefreshableViewController

extension ChatViewController: RefreshableViewController {

    func refresh() {
        chatEmptyView.subtitle = "You're up to date 🎉"
    }
}
