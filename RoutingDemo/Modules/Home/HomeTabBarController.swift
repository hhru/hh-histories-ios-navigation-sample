import UIKit

final class HomeTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = Colors.important
        tabBar.unselectedItemTintColor = Colors.unimportant
    }
}
