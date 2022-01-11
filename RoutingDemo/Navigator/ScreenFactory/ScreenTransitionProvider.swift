import UIKit

final class ScreenTransitionProvider: ViewControllerContextTransitionProvider {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func navigation(for context: ViewControllerContext) -> ViewControllerContextTransition {
        guard let screenType = ScreenType(rawValue: context.screenType) else {
            return PresentModalTransition()
        }

        switch screenType {
        case .authorization:
            return PresentModalTransition()
        case .chat:
            return PushStackTranition()
        case .chatList:
            return PresentModalTransition()
        case .home:
            return SetRootTransition(window: window)
        case .profile:
            return SetupTabTransition()
        case .roomList:
            return SetupTabTransition()
        }
    }
}
