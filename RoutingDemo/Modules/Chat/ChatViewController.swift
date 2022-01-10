import UIKit
import RouteComposer

final class ChatViewController: UIViewController {

    private let chatID: Int
    private let roomID: Int

    private var chatEmptyView: ChatEmptyView {
        view as! ChatEmptyView
    }

    init(chatID: Int, roomID: Int) {
        self.chatID = chatID
        self.roomID = roomID

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

// MARK: - ScreenRefreshableContainer

extension ChatViewController: ScreenRefreshableContainer {

    func refresh(with context: ChatContext) {
        if chatID == context.chatID, roomID == context.roomID {
            chatEmptyView.subtitle = "You're up to date 🎉"
        }
    }
}

// MARK: - ContextChecking

extension ChatViewController: ContextChecking {

    func isTarget(for context: ChatContext) -> Bool {
        chatID == context.chatID && roomID == context.roomID
    }
}
