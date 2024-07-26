//
//  LoginView.swift
//  MovieReservation_4Team
//
//  Created by  on 7/22/24.
//

import UIKit
import SnapKit

class LoginView: UIView {

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
        return button
    }()

    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = FontNames.subFont.font()
        button.setTitleColor(UIColor.mainWhite, for: .normal)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor.mainBlack//확인
        addSubview(logoImageView)
        addSubview(containerView)

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
            $0.leading.equalTo(containerView.snp.leading).offset(24)
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

        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
        }
    }
}
