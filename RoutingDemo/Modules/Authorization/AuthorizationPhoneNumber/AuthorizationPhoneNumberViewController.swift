import UIKit
import Nivelir

final class AuthorizationPhoneNumberViewController: UIViewController {

    private let authorizationCompletion: AuthorizationCompletion
    private let authorizationProvider: AuthorizationProvider

    private let screenKey: ScreenKey
    private let screenNavigator: ScreenNavigator

    init(
        authorizationCompletion: @escaping AuthorizationCompletion,
        authorizationProvider: AuthorizationProvider,
        screenKey: ScreenKey,
        screenNavigator: ScreenNavigator
    ) {
        self.authorizationCompletion = authorizationCompletion
        self.authorizationProvider = authorizationProvider
        self.screenKey = screenKey
        self.screenNavigator = screenNavigator

        super.init(nibName: nil, bundle: nil)

        title = "Authorization"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPhoneNumberView() {
        let phoneNumberView = AuthorizationPhoneNumberView()

        view.addSubview(phoneNumberView)

        phoneNumberView.onLoginButtonTap = { [unowned self] phone in
            self.authorizationProvider.updateAuthorizationState(to: true)

            self.dismiss(animated: true) {
                self.authorizationCompletion(.authorized)
            }
        }

        phoneNumberView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.background
        navigationController?.presentationController?.delegate = self

        setupPhoneNumberView()
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension AuthorizationPhoneNumberViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        authorizationCompletion(.notAuthorized)
    }
}
