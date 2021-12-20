import UIKit

struct RoomListScreen {

    func build() -> UIViewController {
        RoomListViewController(authorizationProvider: DefaultAuthorizationProvider.shared)
    }
}
