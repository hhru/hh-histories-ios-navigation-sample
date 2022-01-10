import RouteComposer
import UIKit

enum Screens {

    static func homeScreen(router: Router) -> DestinationStep<HomeTabBarController, Any?> {
        StepAssembly(
            finder: ClassFinder<HomeTabBarController, Any?>(options: .current, startingPoint: .root),
            factory: CompleteFactoryAssembly(factory: HomeScreen(router: router))
                .with(
                    CompleteFactoryAssembly(
                        factory: NavigationControllerFactory<UINavigationController, Any?>(
                            configuration: { navigationController in
                                navigationController.tabBarItem = .profile
                            }
                        )
                    ).with(ProfileScreen()).assemble(),
                    using: HomeTabBarController.add()
                )
                .with(
                    CompleteFactoryAssembly(
                        factory: NavigationControllerFactory<UINavigationController, Any?>(
                            configuration: { navigationController in
                                navigationController.tabBarItem = .rooms
                            }
                        )
                    ).with(RoomListScreen(router: router)).assemble(),
                    using: HomeTabBarController.add()
                )
                .assemble()
        )
            .using(GeneralAction.replaceRoot())
            .from(GeneralStep.root())
            .assemble()
    }

    static func roomListScreen(router: Router) -> DestinationStep<RoomListViewController, Any?> {
        StepAssembly(finder: ClassFinder<RoomListViewController, Any?>(), factory: NilFactory())
            .from(homeScreen(router: router))
            .assemble()
    }

    static func chatListScreen(router: Router) -> DestinationStep<ChatListViewController, ChatContext> {
        StepAssembly(
            finder: ClassFinder<ChatListViewController, ChatContext>(),
            factory: ChatListScreen(router: router)
        )
            .adding(
                AuthorizationInterceptor(authorizationProvider: DefaultAuthorizationProvider.shared, router: router)
            )
            .using(UINavigationController.push())
            .from(NavigationControllerStep<UINavigationController, ChatContext>())
            .using(GeneralAction.presentModally(presentationStyle: .formSheet))
            .from(roomListScreen(router: router).unsafelyRewrapped())
            .assemble()
    }

    static func chatScreen(router: Router) -> DestinationStep<ChatViewController, ChatContext> {
        StepAssembly(
            finder: ClassFinder<ChatViewController, ChatContext>(options: .currentAllStack),
            factory: ChatScreen()
        )
            .using(UINavigationController.push())
            .from(chatListScreen(router: router).expectingContainer())
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
