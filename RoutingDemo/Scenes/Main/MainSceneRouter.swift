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
        navigator.navigate { route in
            route
                .top(.container(of: ChatScreen(chatID: chatID)))
                .refresh()
                .fallback { error, route in
                    route
                        .first(.tabs)
                        .selectTab(with: .index(1), route: { route in
                            route
                                .dismiss()
                                .authorized(with: DefaultAuthorizationProvider.shared)
                                .present(ChatListScreen(roomID: roomID).withStackContainer()) { route in
                                    route.push(ChatScreen(chatID: chatID))
                                }
                        })
                }
        }
    }
}
