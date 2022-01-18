import UIKit

final class MainSceneRouter {

    let router: ViewControllerContextRouterProtocol
    let authorizationProvider: AuthorizationProvider

    init(router: ViewControllerContextRouterProtocol, authorizationProvider: AuthorizationProvider) {
        self.router = router
        self.authorizationProvider = authorizationProvider
    }

    private func navigatoToChat(roomID: Int, chatID: Int) {
        router.navigateToScreen(.roomList, animated: true)
        router.navigateToScreen(.chat, with: ChatContextInfo(roomID: roomID, chatID: chatID), animated: true)
    }

    func showRootScreen() {
        router.navigateToScreen(.home, animated: false)
    }

    func showChat(roomID: Int, chatID: Int) {
        if authorizationProvider.isAuthorized {
            navigatoToChat(roomID: roomID, chatID: chatID)
        } else {
            router.navigateToScreen(
                .authorization,
                with: AuthorizationPhoneNumberContextInfo(authorizationCompletion: { [unowned self] result in
                    if result.isAuthorized {
                        self.navigatoToChat(roomID: roomID, chatID: chatID)
                    }
                }),
                animated: true
            )
        }
    }
}
