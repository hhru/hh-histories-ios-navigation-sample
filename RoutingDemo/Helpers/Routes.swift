import Nivelir

enum Routes {

    static func roomListRoute(
        nextRoute: (_ route: ScreenModalRoute) -> ScreenRouteConvertible
    ) -> ScreenRoute<UIWindow, UITabBarController> {
        ScreenWindowRoute
            .initial
            .first(.tabs)
            .selectTab(with: .index(1), route: nextRoute)
    }

    static func chatListRoute(
        roomID: Int,
        nextRoute: (_ route: ScreenStackRoute) -> ScreenRouteConvertible
    ) -> ScreenRoute<UIWindow, UIWindow> {
        ScreenWindowRoute
            .initial
            .first(.container(of: ChatListScreen(roomID: roomID)))
            .stack(route: { route in
                nextRoute(route.popToRoot())
            })
            .fallback(
                to: roomListRoute(nextRoute: { route in
                    route
                        .dismiss()
                        .authorized(with: DefaultAuthorizationProvider.shared)
                        .present(ChatListScreen(roomID: roomID).withStackContainer(), route: nextRoute)
                })
            )
    }

    static func chatRoute(roomID: Int, chatID: Int) -> ScreenWindowRoute {
        ScreenWindowRoute
            .initial
            .top(
                .container(of: ChatScreen(roomID: roomID, chatID: chatID))
            )
            .refresh()
            .fallback(
                to: chatListRoute(roomID: roomID, nextRoute: { route in
                    route.push(ChatScreen(roomID: roomID, chatID: chatID))
                })
            )
    }
}
