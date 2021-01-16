//
//  SigninViewModel.swift
//  MVVM IO
//
//  Created by Jaime Jazareno III on 1/13/21.
//  Copyright © 2021 Jaime Jazareno III. All rights reserved.
//

import RxCocoa
import RxSwift

protocol SigninViewModelInputs {
    func didChange(email: String)
    func didChange(password: String)
}

protocol SigninViewModelOutputs {
    var isEmailValid: PublishRelay<TextFieldStatus> { get }
    var isPasswordValid: PublishRelay<TextFieldStatus> { get }
    var isAuthValid: PublishRelay<TextFieldStatus> { get }
    var emailNotValidErrMssg: PublishRelay<String> { get }
    var passwordNotValidErrMssg: PublishRelay<String> { get }
}

protocol SigninViewModelTypes {
    var inputs: SigninViewModelInputs { get }
    var outputs: SigninViewModelOutputs { get }
}


class SigninViewModel: SigninViewModelTypes, SigninViewModelOutputs, SigninViewModelInputs {
    var inputs: SigninViewModelInputs { return self }
    var outputs: SigninViewModelOutputs { return self }

    var isEmailValid: PublishRelay<TextFieldStatus> = PublishRelay()
    var isPasswordValid: PublishRelay<TextFieldStatus> = PublishRelay()
    var isAuthValid: PublishRelay<TextFieldStatus> = PublishRelay()
    var emailNotValidErrMssg: PublishRelay<String> = PublishRelay()
    var passwordNotValidErrMssg: PublishRelay<String> = PublishRelay()

    private var disposeBag: DisposeBag = DisposeBag()

    private var didChangeEmailProperty = PublishSubject<String>()
    func didChange(email: String) {
        didChangeEmailProperty.onNext(email)
    }

    private var didChangePasswordProperty = PublishSubject<String>()
    func didChange(password: String) {
        didChangePasswordProperty.onNext(password)
    }

    init() {
        didChangeEmailProperty.map(isValidEmail(_:)).bind(to: isEmailValid).disposed(by: disposeBag)

        isEmailValid.filter { $0 == .notValid }
            .map { _ in "Entered email is not valid." }
            .bind(to: emailNotValidErrMssg)
            .disposed(by: disposeBag)

        isPasswordValid.filter { $0 == .notValid }
            .map { _ in "Password has to be from 6 to 20 characters long." }
            .bind(to: passwordNotValidErrMssg)
            .disposed(by: disposeBag)

        isEmailValid.filter { $0 == .valid }
            .map { _ in "" }
            .bind(to: emailNotValidErrMssg)
            .disposed(by: disposeBag)

        isPasswordValid.filter { $0 == .valid }
            .map { _ in "" }
            .bind(to: passwordNotValidErrMssg)
            .disposed(by: disposeBag)

        didChangePasswordProperty
            .map { $0.count > 5 && $0.count < 21 ? .valid : .notValid }
            .bind(to: isPasswordValid)
            .disposed(by: disposeBag)
    }

    private func isValidEmail(_ email: String) -> TextFieldStatus {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? .valid : .notValid
    }
}

