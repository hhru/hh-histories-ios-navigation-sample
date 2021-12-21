import UIKit
import Nivelir

struct AuthorizationPhoneNumberScreen: Screen {

    let authorizationCompletion: AuthorizationCompletion

    func build(navigator: ScreenNavigator) -> UIViewController {
        AuthorizationPhoneNumberViewController(
            authorizationCompletion: authorizationCompletion,
            authorizationProvider: DefaultAuthorizationProvider.shared,
            screenKey: key,
            screenNavigator: navigator
        )
    }
}
