import UIKit

final class MainSceneRouter {

    let router: ViewControllerContextRouterProtocol
    let authorizationProvider: AuthorizationProvider

    init(router: ViewControllerContextRouterProtocol, authorizationProvider: AuthorizationProvider) {
        self.router = router
        self.authorizationProvider = authorizationProvider
    }

    func showRootScreen() {
        router.navigateToScreen(.home, animated: false)
    }

    func showChat(roomID: Int, chatID: Int) {
        if authorizationProvider.isAuthorized {
            router.navigateToScreen(.chat, with: ChatContextInfo(roomID: roomID, chatID: chatID), animated: true)
        } else {
            router.navigateToScreen(
                .authorization,
                with: AuthorizationPhoneNumberContextInfo(authorizationCompletion: { [unowned self] result in
                    if result.isAuthorized {
                        self.router.navigateToScreen(
                            .chat,
                            with: ChatContextInfo(roomID: roomID, chatID: chatID),
                            animated: true
                        )
                    }
                }),
                animated: true
            )
        }
    }
}
