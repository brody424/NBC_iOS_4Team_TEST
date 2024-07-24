//
//  SignUpVIew.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class SignUpView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nameTextField = UITextField()
    let hpTextField = UITextField()
    let signUpButton = UIButton(type: .system)
    let profileImageView = UIImageView()
    let changeProfileButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .black
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect

        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect

        hpTextField.placeholder = "H.P"
        hpTextField.borderStyle = .roundedRect

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.mainRed
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)

        // 기본 프로필 이미지 설정
        profileImageView.image = UIImage(named: "profile")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        //  profileImageView.addGestureRecognizer(tapGesture)

        changeProfileButton.setTitle("프로필 변경", for: .normal)
        changeProfileButton.tintColor = .white
        changeProfileButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)

        [emailTextField, passwordTextField, signUpButton, nameTextField, hpTextField, profileImageView, changeProfileButton].forEach { view.addSubview($0) }

        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(150)
        }

        emailTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(changeProfileButton.snp.bottom).offset(20)
        }

        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
        }

        nameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }

        hpTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
        }

        signUpButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(hpTextField.snp.bottom).offset(20)
        }

        changeProfileButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
    }

    @objc private func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }


    @objc private func loginButtonTapped() {
        self.navigationController?.pushViewController(LoginView(), animated: true)
    }
}

#Preview("SignUpView") {SignUpView()}
