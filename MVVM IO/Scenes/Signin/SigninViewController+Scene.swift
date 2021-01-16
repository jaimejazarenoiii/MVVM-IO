//
//  SigninViewController+Scene.swift
//  MVVM IO
//
//  Created by Jaime Jazareno III on 1/13/21.
//  Copyright © 2021 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension SigninViewController {
    func setupScene() {
        setupEmailTextField()
        setupEmailErrLabel()
        setupPasswordTextField()
        setupPasswordErrLabel()
        setupSigninButton()
    }

    private func setupEmailTextField() {
        emailTextField.placeholder = "Email"
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.4
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress

        view.addSubview(emailTextField)

        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    private func setupEmailErrLabel() {
        emailErrLabel.textColor = .red
        emailErrLabel.font = .systemFont(ofSize: 11)
        emailErrLabel.numberOfLines = 0

        view.addSubview(emailErrLabel)

        emailErrLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
            make.left.right.equalTo(emailTextField)
        }
    }

    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.4
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none

        view.addSubview(passwordTextField)

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailErrLabel.snp.bottom).offset(20)
            make.height.left.right.equalTo(emailTextField)
        }
    }

    private func setupPasswordErrLabel() {
        passwordErrLabel.textColor = .red
        passwordErrLabel.font = .systemFont(ofSize: 11)
        passwordErrLabel.numberOfLines = 0

        view.addSubview(passwordErrLabel)

        passwordErrLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
            make.left.right.equalTo(emailTextField)
        }
    }

    private func setupSigninButton() {
        signinButton.backgroundColor = .blue
        signinButton.setTitle("Sign in", for: .normal)

        view.addSubview(signinButton)

        signinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordErrLabel.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
            make.bottom.lessThanOrEqualToSuperview()
            make.height.equalTo(50)
        }

    }


}
