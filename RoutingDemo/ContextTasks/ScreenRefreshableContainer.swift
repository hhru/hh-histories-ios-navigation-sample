import UIKit

protocol ScreenRefreshableContainer: UIViewController {

    associatedtype Context

    func refresh(with context: Context)
}
