//
//  LoginViewController.swift
//  MovieReservation_4Team
//
//  Created by 이진규 on 7/26/24.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }

    @objc private func signupButtonTapped() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

    @objc private func loginButtonTapped() {
        // 로그인 성공 여부 확인
        let isLoginSuccessful = performLogin()

        if isLoginSuccessful {
            switchToTabBarController()
        } else {
            // 로그인 실패 시 사용자에게 알림
            showAlertForLoginFailure()
        }
    }

    private func performLogin() -> Bool {
        guard let id = loginView.idTextField.text, let password = loginView.passwordTextField.text else {
            return false
        }
        return CoreDataManager.shared.validateUser(id: id, password: password)
    }

    private func switchToTabBarController() {
        // TabBarController 생성
        let tabBarController = TabBarController()

        // 현재 네비게이션 컨트롤러의 루트 뷰 컨트롤러를 TabBarController로 설정
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }

    private func showAlertForLoginFailure() {
        let alert = UIAlertController(title: "로그인 실패", message: "Please check your credentials and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        // 실패 시 회원가입으로
        alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { _ in
            self.signupButtonTapped()
        }))
        present(alert, animated: true)
    }
}

