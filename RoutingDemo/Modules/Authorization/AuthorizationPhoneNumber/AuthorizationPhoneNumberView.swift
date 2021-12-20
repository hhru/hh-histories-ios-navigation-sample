import UIKit
import HandlersKit

final class AuthorizationPhoneNumberView: UIView {

    private let subtitleLabel = UILabel()
    private let phoneInputTextField = UITextField()
    private let loginButton = UIButton(type: .system)

    var onLoginButtonTap: ((_ phone: String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Colors.background

        setupSubtitleLabel()
        setupPhoneInputTextField()
        setupLoginButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)

        subtitleLabel.text = "Enter your phone number\nto log in"
        subtitleLabel.textColor = Colors.title.withAlphaComponent(0.3)
        subtitleLabel.font = .systemFont(ofSize: 16.0)
        subtitleLabel.numberOfLines = 2

        subtitleLabel.snp.makeConstraints { make in
            make.top.left.trailing.equalToSuperview().inset(24.0)
        }
    }

    private func setupPhoneInputTextField() {
        addSubview(phoneInputTextField)

        phoneInputTextField.text = "+7"
        phoneInputTextField.textColor = Colors.title
        phoneInputTextField.font = .systemFont(ofSize: 24.0)
        phoneInputTextField.borderStyle = .none
        phoneInputTextField.textContentType = .telephoneNumber
        phoneInputTextField.returnKeyType = .done

        phoneInputTextField.shouldReturn { textField in
            textField.resignFirstResponder()
        }

        phoneInputTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32.0)
            make.left.right.equalToSuperview().inset(24.0)
        }
    }

    private func setupLoginButton() {
        addSubview(loginButton)

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(Colors.important, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15.0)
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        loginButton.layer.borderColor = Colors.important.cgColor
        loginButton.layer.borderWidth = 1.0

        loginButton.onTap { [unowned self] in
            self.onLoginButtonTap?(self.phoneInputTextField.text ?? "")
        }

        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24.0)
            make.bottom.equalToSuperview().inset(32.0)
            make.height.equalTo(48.0)
        }
    }
}
