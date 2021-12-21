import Nivelir

struct ScreenAuthorizedAction<Container: UIViewController>: ScreenAction {

    typealias Output = Container

    let authorizationProvider: AuthorizationProvider

    init(authorizationProvider: AuthorizationProvider) {
        self.authorizationProvider = authorizationProvider
    }

    func perform(
        container: Container,
        navigator: ScreenNavigator,
        completion: @escaping Completion
    ) {
        navigator.logInfo("Presenting authorization flow if needed")

        if authorizationProvider.isAuthorized {
            completion(.success(container))
        } else {
            navigator.navigate(from: container) { route in
                route.present(
                    AuthorizationPhoneNumberScreen(authorizationCompletion: { result in
                        switch result {
                        case .authorized:
                            completion(.success(container))

                        case .notAuthorized:
                            completion(.authorizationCancelled(for: self))
                        }
                    }).withStackContainer()
                )
            }
        }
    }
}

extension ScreenThenable where Current: UIViewController {

    func authorized<Route: ScreenThenable>(
        with provider: AuthorizationProvider,
        route: Route
    ) -> Self where Route.Root == Current {
        fold(
            action: ScreenAuthorizedAction<Current>(authorizationProvider: provider),
            nested: route
        )
    }

    func authorized(
        with provider: AuthorizationProvider,
        route: (
            _ route: ScreenRootRoute<UIImagePickerController>
        ) -> ScreenRouteConvertible = { $0 }
    ) -> Self {
        authorized(
            with: provider,
            route: route(.initial).route()
        )
    }
}
