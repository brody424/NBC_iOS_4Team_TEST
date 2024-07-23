//
//  LoginView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class LoginView: UIViewController {

    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let signupButton = UIButton(type: .system)
    let logoImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .black

        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        // passwordTextField.isSecureTextEntry = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.mainRed
        loginButton.titleLabel?.font = FontNames.subFont.font()
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 10

        signupButton.setTitle("signup", for: .normal)
        signupButton.tintColor = .white
        signupButton.addTarget(self, action: #selector(buttonTapped), for: .touchDown)

        logoImageView.image = UIImage(named: "nigabox")
        logoImageView.contentMode = .scaleAspectFill

        [usernameTextField, passwordTextField, loginButton, signupButton, logoImageView]
                  .forEach { view.addSubview($0) }


        usernameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(350)
        }

        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }

        signupButton.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
        }
        logoImageView.snp.makeConstraints{
            $0.width.equalTo(330)//둘다 같을 때 묶어서 사용가능
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
    }

    @objc private func buttonTapped() {
            self.navigationController?.pushViewController(SignUpVIew(), animated: true)
    }
}

#Preview("LoginView") {LoginView()}
