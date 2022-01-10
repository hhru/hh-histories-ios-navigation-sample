import RouteComposer

final class AuthorizationInterceptor<Context>: RoutingInterceptor {

    let authorizationProvider: AuthorizationProvider
    let router: Router

    init(authorizationProvider: AuthorizationProvider, router: Router) {
        self.authorizationProvider = authorizationProvider
        self.router = router
    }

    func perform(with context: Context, completion: @escaping (RoutingResult) -> Void) {
        if authorizationProvider.isAuthorized {
            completion(.success)
        } else {
            do {
                try router.navigate(
                    to: Screens.loginScreen(authorizationCompletion: { result in
                        switch result {
                        case .authorized:
                            completion(.success)

                        case .notAuthorized:
                            completion(
                                .failure(
                                    RoutingError.compositionFailed(RoutingError.Context("Authorization was cancelled"))
                                )
                            )
                        }
                    }),
                    animated: true,
                    completion: nil
                )
            } catch {
                completion(.failure(error))
            }
        }
    }
}
