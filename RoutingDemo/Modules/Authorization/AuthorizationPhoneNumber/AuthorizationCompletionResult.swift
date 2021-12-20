import Foundation

public enum AuthorizationCompletionResult {
    case authorized
    case notAuthorized

    public var isAuthorized: Bool {
        self == .authorized
    }
}
