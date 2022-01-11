import Foundation

struct AuthorizationPhoneNumberContextInfo: ViewControllerContextInfo {

    let authorizationCompletion: AuthorizationCompletion

    func isEqual(to info: ViewControllerContextInfo?) -> Bool {
        true
    }
}
