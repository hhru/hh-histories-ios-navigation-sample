import UIKit

final class TabsContextSwitcher: ViewControllerContextSwitcher {

    private let window: UIWindow

    private var tabBar: UITabBarController? {
        window.rootViewController as? UITabBarController
    }

    private let tabsMap: [String: Int] = [
        ScreenType.profile.rawValue : 0,
        ScreenType.roomList.rawValue: 1
    ]

    init(window: UIWindow) {
        self.window = window
    }

    func canSwitch(to context: ViewControllerContext) -> Bool {
        guard tabBar?.viewControllers?.count == tabsMap.count,
              let screenType = ScreenType(rawValue: context.screenType) else {
            return false
        }

        return screenType == .profile || screenType == .roomList
    }

    func switchContext(to context: ViewControllerContext, animated: Bool) {
        guard canSwitch(to: context), let index = tabsMap[context.screenType] else {
            return
        }

        tabBar?.selectedIndex = index
    }
}
