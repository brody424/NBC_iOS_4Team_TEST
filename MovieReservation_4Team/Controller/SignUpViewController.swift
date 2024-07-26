//
//  SignUpViewController.swift
//  MovieReservation_4Team
//
//  Created by 이진규 on 7/26/24.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let signUpView = SignUpVIew()

    override func loadView() {
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        signUpView.changeProfileButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }

    @objc private func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            signUpView.profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    @objc private func signupButtonTapped() {
        guard let id = signUpView.idTextField.text, !id.isEmpty,
              let password = signUpView.passwordTextField.text, !password.isEmpty,
              let name = signUpView.nameTextField.text, !name.isEmpty,
              let phone = signUpView.hpTextField.text, !phone.isEmpty else {
            showAlertForSignUpFailure(message: "작성하세요.")
            return
        }

        let userProfileImageData = signUpView.profileImageView.image?.pngData()

        CoreDataManager.shared.saveUser(name: name, phone: phone, id: id, password: password, userprofile: userProfileImageData)

        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }

    private func showAlertForSignUpFailure(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
