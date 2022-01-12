import Foundation

extension ViewControllerContext {

    init(screenType: ScreenType, info: ViewControllerContextInfo?) {
        self.screenType = screenType.rawValue
        self.info = info
    }
}
