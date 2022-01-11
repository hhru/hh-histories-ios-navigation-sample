import UIKit

final class AuthorizationContextSwitcher: ViewControllerContextSwitcher {

    private let authorizationProvider: AuthorizationProvider

    weak var router: ViewControllerContextRouterProtocol?

    init(authorizationProvider: AuthorizationProvider) {
        self.authorizationProvider = authorizationProvider
    }

    func canSwitch(to context: ViewControllerContext) -> Bool {
        guard let screenType = ScreenType(rawValue: context.screenType) else {
            return false
        }

        return !authorizationProvider.isAuthorized && screenType == .chatList
    }

    func switchContext(to context: ViewControllerContext, animated: Bool) {
        router?.navigateToScreen(
            .authorization,
            with: AuthorizationPhoneNumberContextInfo(authorizationCompletion: { [unowned self] result in
                if result.isAuthorized {
                    self.router?.navigateToContext(context, animated: animated)
                }
            }),
            animated: animated
        )
    }
}
