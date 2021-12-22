import UIKit
import Nivelir

final class MainSceneRouter {

    let navigator: ScreenNavigator

    init(navigator: ScreenNavigator) {
        self.navigator = navigator
    }

    func showRootScreen() {
        navigator.navigate { route in
            route.setRoot(to: HomeScreen())
        }
    }

    func showChat(roomID: Int, chatID: Int) {
        print("showChat(roomID: \(roomID)), chatID: \(chatID))")

        let chatScreenFromTabRoute = ScreenModalRoute
            .initial
            .dismiss()
            .authorized(with: DefaultAuthorizationProvider.shared)
            .present(ChatListScreen(roomID: roomID).withStackContainer()) { route in
                route.push(ChatScreen(chatID: chatID))
            }

        let chatScreenFromChatListScreenRoute = ScreenModalRoute
            .initial
            .first(.container(of: ChatListScreen(roomID: roomID)))
            .stack
            .popToRoot()
            .push(ChatScreen(chatID: chatID))
            .fallback(to: chatScreenFromTabRoute)

        let selectTabRoute = ScreenWindowRoute
            .initial
            .first(.tabs)
            .selectTab(with: .index(1), route: chatScreenFromChatListScreenRoute)

        let refreshChatScreenRoute = ScreenWindowRoute
            .initial
            .top(.container(of: ChatScreen(chatID: chatID)))
            .refresh()
            .fallback(to: selectTabRoute)

        navigator.navigate(to: refreshChatScreenRoute)
    }
}
