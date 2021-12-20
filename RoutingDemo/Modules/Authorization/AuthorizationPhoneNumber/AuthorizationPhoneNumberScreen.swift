import UIKit

struct AuthorizationPhoneNumberScreen {

    let authorizationCompletion: AuthorizationCompletion

    func build() -> UIViewController {
        AuthorizationPhoneNumberViewController(
            authorizationCompletion: authorizationCompletion,
            authorizationProvider: DefaultAuthorizationProvider.shared
        )
    }
}
