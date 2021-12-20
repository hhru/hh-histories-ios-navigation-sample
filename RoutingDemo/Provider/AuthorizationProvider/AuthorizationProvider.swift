import Foundation

protocol AuthorizationProvider {

    var isAuthorized: Bool { get }

    func updateAuthorizationState(to authorized: Bool)
}
