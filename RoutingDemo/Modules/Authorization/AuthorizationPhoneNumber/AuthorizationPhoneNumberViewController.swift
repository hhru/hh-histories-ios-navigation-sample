import UIKit

final class AuthorizationPhoneNumberViewController: UIViewController {

    private let authorizationCompletion: AuthorizationCompletion
    private let authorizationProvider: AuthorizationProvider

    private var authorizationPhoneNumberView: AuthorizationPhoneNumberView {
        view as! AuthorizationPhoneNumberView
    }

    init(authorizationCompletion: @escaping AuthorizationCompletion, authorizationProvider: AuthorizationProvider) {
        self.authorizationCompletion = authorizationCompletion
        self.authorizationProvider = authorizationProvider

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

        setupPhoneNumberView()
    }
}
