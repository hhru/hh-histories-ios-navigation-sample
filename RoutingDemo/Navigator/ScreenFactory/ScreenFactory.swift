import UIKit

final class ScreenFactory: ViewControllersByContextFactory {

    weak var router: ViewControllerContextRouterProtocol?

    func viewController(for context: ViewControllerContext) -> UIViewController? {
        guard let screenType = ScreenType(rawValue: context.screenType), let router = router else {
            return nil
        }

        switch screenType {
        case .authorization:
            guard let contextInfo = context.info as? AuthorizationPhoneNumberContextInfo else {
                return nil
            }

            return AuthorizationPhoneNumberScreen(authorizationCompletion: contextInfo.authorizationCompletion).build()
        case .chat:
            guard let chatID = context.info as? Int else {
                return nil
            }

            return ChatScreen(chatID: chatID).build()
        case .chatList:
            guard let roomID = context.info as? Int else {
                return nil
            }

            return ChatListScreen(roomID: roomID, router: router).build()
        case .home:
            return HomeScreen(router: router).build()
        case .profile:
            return ProfileScreen().build()
        case .roomList:
            return RoomListScreen(router: router).build()
        }
    }
}
