//
//  SigninViewController.swift
//  MVVM IO
//
//  Created by Jaime Jazareno III on 1/13/21.
//  Copyright © 2021 Jaime Jazareno III. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

enum TextFieldStatus {
    case valid, notValid

    var borderColor: CGColor {
        switch self {
        case .valid: return UIColor.lightGray.cgColor
        default: return UIColor.red.cgColor
        }
    }
}

class SigninViewController: UIViewController {

    var viewModel: SigninViewModelTypes

    lazy var emailTextField: UITextField = UITextField()
    lazy var emailErrLabel: UILabel = UILabel()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var passwordErrLabel: UILabel = UILabel()
    lazy var signinButton: UIButton = UIButton()
    lazy var disposeBag = DisposeBag()

    init(viewModel: SigninViewModelTypes) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        emailTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(onNext: viewModel.inputs.didChange(email:))
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(onNext: viewModel.inputs.didChange(password:))
            .disposed(by: disposeBag)

        viewModel.outputs.isEmailValid.map { $0.borderColor }
            .bind(to: emailTextField.rx.borderColor)
            .disposed(by: disposeBag)

        viewModel.outputs.isPasswordValid.map { $0.borderColor }
            .bind(to: passwordTextField.rx.borderColor)
            .disposed(by: disposeBag)

        viewModel.outputs.emailNotValidErrMssg.bind(to: emailErrLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.passwordNotValidErrMssg.bind(to: passwordErrLabel.rx.text).disposed(by: disposeBag)
    }
}
