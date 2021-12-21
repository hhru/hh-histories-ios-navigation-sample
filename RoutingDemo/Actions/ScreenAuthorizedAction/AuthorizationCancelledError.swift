import Nivelir

struct AuthorizationCancelledError: ScreenError {

    var description: String {
        """
        Authorization was cancelled for:
          \(trigger)
        """
    }

    let trigger: Any

    init(for trigger: Any) {
        self.trigger = trigger
    }
}

extension Result where Failure == Error {

    static func authorizationCancelled(for trigger: Any) -> Self {
        .failure(AuthorizationCancelledError(for: trigger))
    }
}
