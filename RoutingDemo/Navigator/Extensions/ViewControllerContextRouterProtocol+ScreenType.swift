import Foundation

extension ViewControllerContextRouterProtocol {

    func navigateToScreen(
        _ screenType: ScreenType,
        with contextInfo: ViewControllerContextInfo? = nil,
        animated: Bool
    ) {
        navigateToContext(ViewControllerContext(screenType: screenType.rawValue, info: contextInfo), animated: animated)
    }
}
