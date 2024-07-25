//
//  LoginView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class LoginView: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.subFont2.font()
        return label
    }()

    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.mainWhite
        return textField
    }()

    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.subFont2.font()
        return label
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.mainWhite
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.mainRed
        button.titleLabel?.font = FontNames.subFont2.font()
        button.setTitleColor(UIColor.mainWhite, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = FontNames.subFont.font()
        button.setTitleColor(UIColor.mainWhite, for: .normal)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainWhite.cgColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureUI()
    }

    private func setupViews() {

        view.backgroundColor = UIColor.mainBlack
        view.addSubview(logoImageView)
        view.addSubview(containerView)

        containerView.addSubview(idLabel)
        containerView.addSubview(idTextField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(signupButton)
    }

    private func configureUI() {

        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(140)
            $0.width.equalTo(330)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(340)
        }

        idLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(24)
            $0.top.equalTo(containerView.snp.top).offset(38)
        }

        idTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(containerView).inset(24)
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
        }


        passwordLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
        }

        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(containerView).inset(24)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(containerView).inset(24)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
        }

        // 가입 버튼 설정
        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
        }
    }

    @objc private func signupButtonTapped() {
        self.navigationController?.pushViewController(SignUpView(), animated: true)
    }

    @objc private func loginButtonTapped() {
        let tabBarController = TabBarController()
                let navigationController = UINavigationController(rootViewController: tabBarController)

                // 루트 뷰 컨트롤러를 업데이트
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
    }
}

#Preview("LoginView")
{LoginView()
}
