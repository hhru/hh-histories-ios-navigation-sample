import UIKit

struct AuthorizationPhoneNumberScreen {

    let authorizationCompletion: AuthorizationCompletion

    func build() -> UINavigationController {
        UINavigationController(
            rootViewController: AuthorizationPhoneNumberViewController(
                authorizationCompletion: authorizationCompletion,
                authorizationProvider: DefaultAuthorizationProvider.shared
            )
        )
    }
}
