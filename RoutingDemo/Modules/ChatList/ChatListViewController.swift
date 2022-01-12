import UIKit

final class ChatListViewController: UITableViewController {

    private let roomID: Int
    private let router: ViewControllerContextRouterProtocol

    private var chatCount = Int.random(in: 3...10)

    init(roomID: Int, router: ViewControllerContextRouterProtocol) {
        self.roomID = roomID
        self.router = router

        super.init(nibName: nil, bundle: nil)

        self.title = "Chats – Room #\(roomID)"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showChat(id: Int) {
        router.navigateToScreen(.chat, with: ChatContextInfo(roomID: roomID, chatID: id), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.background

        tableView.separatorStyle = .none
        tableView.registerReusableCell(of: ChatListCell.self)
    }
}

extension ChatListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: ChatListCell.self, for: indexPath)

        cell.title = "Chat \(indexPath.row)"
        cell.subtitle = "Empty chat"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        showChat(id: indexPath.item)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72.0
    }
}

// MARK: - ViewControllerContextHolder

extension ChatListViewController: ViewControllerContextHolder {

    var currentContext: ViewControllerContext? {
        ViewControllerContext(screenType: .chatList, info: roomID)
    }
}
