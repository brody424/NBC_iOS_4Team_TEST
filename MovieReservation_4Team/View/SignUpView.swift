//
//  SignUpVIew.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class SignUpView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        //  profileImageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    lazy var changeProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 변경", for: .normal)
        button.titleLabel?.font = FontNames.mainFont.font()
        button.setTitleColor(UIColor.mainRed, for: .normal)
        button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)

        return button
    }()

    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.textColor = .white
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
        label.textColor = .white
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

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.font = FontNames.subFont2.font()
        return label
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.mainWhite
        return textField
    }()

    let hpLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.textColor = .white
        label.font = FontNames.subFont2.font()
        return label
    }()

    let hpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "010 - 0000 - 0000"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.mainWhite
        return textField
    }()

   lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.mainRed
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor.mainBlack

        [
            profileImageView,
            changeProfileButton,
            idLabel, 
            idTextField,
            passwordLabel, 
            passwordTextField,
            nameLabel, 
            nameTextField,
            hpLabel, 
            hpTextField,
            signUpButton
        ].forEach { view.addSubview($0) }

        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(140)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(110)
        }

        changeProfileButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
        }

        idLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(changeProfileButton.snp.bottom).offset(8)
        }

        idTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(idLabel.snp.bottom).offset(2)
        }

        passwordLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
        }

        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(2)
        }

        nameLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }

        nameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
        }

        hpLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
        }
        hpTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(hpLabel.snp.bottom).offset(2)
        }

        signUpButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(hpTextField.snp.bottom).offset(32)
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
