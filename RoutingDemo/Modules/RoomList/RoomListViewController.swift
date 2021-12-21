import UIKit
import Nivelir

final class RoomListViewController: UITableViewController, ScreenKeyedContainer {

    private let authorizationProvider: AuthorizationProvider

    private var chatCount = Int.random(in: 3...10)

    let screenKey: ScreenKey
    let screenNavigator: ScreenNavigator

    init(authorizationProvider: AuthorizationProvider, screenKey: ScreenKey, screenNavigator: ScreenNavigator) {
        self.authorizationProvider = authorizationProvider
        self.screenKey = screenKey
        self.screenNavigator = screenNavigator

        super.init(nibName: nil, bundle: nil)

        self.title = "Private Rooms"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showChatList(index: Int) {
        screenNavigator.navigate(from: self) { route in
            route
                .authorized(with: authorizationProvider)
                .present(ChatListScreen(roomID: index).withStackContainer())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.background

        tableView.separatorStyle = .none
        tableView.registerReusableCell(of: RoomListCell.self)
    }
}

extension RoomListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: RoomListCell.self, for: indexPath)

        cell.title = "Room #\(indexPath.row)"
        cell.subtitle = "iOS chats about routing"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        showChatList(index: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72.0
    }
}
