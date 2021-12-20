import Foundation

final class DefaultAuthorizationProvider: AuthorizationProvider {

    static let shared = DefaultAuthorizationProvider()

    var isAuthorized = false

    private init() { }

    func updateAuthorizationState(to authorized: Bool) {
        isAuthorized = authorized
    }
}
