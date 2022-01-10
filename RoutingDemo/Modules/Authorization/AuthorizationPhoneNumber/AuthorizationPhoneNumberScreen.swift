import UIKit
import RouteComposer

struct AuthorizationPhoneNumberScreen: Factory {

    typealias ViewController = AuthorizationPhoneNumberViewController
    typealias Context = Void

    let authorizationCompletion: AuthorizationCompletion

    func build(with context: Void) throws -> AuthorizationPhoneNumberViewController {
        AuthorizationPhoneNumberViewController(
            authorizationCompletion: authorizationCompletion,
            authorizationProvider: DefaultAuthorizationProvider.shared
        )
    }
}
