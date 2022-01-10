import RouteComposer

enum Screens {

    static func chatListScreen(router: Router) -> DestinationStep<ChatListViewController, Int> {
        StepAssembly(finder: ClassFinder<ChatListViewController, Int>(), factory: ChatListScreen())
            .adding(
                AuthorizationInterceptor(authorizationProvider: DefaultAuthorizationProvider.shared, router: router)
            )
            .using(UINavigationController.push())
            .from(NavigationControllerStep<UINavigationController, Int>())
            .using(GeneralAction.presentModally(presentationStyle: .formSheet))
            .from(GeneralStep.current())
            .assemble()
    }

    static func loginScreen(
        authorizationCompletion: @escaping AuthorizationCompletion
    ) -> DestinationStep<AuthorizationPhoneNumberViewController, Void> {
        StepAssembly(
            finder: ClassFinder<AuthorizationPhoneNumberViewController, Void>(),
            factory: AuthorizationPhoneNumberScreen(authorizationCompletion: authorizationCompletion)
        )
            .using(UINavigationController.push())
            .from(NavigationControllerStep<UINavigationController, Void>())
            .using(GeneralAction.presentModally(presentationStyle: .formSheet))
            .from(GeneralStep.current())
            .assemble()
    }
}
