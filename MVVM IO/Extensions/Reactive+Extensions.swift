//
//  Reactive+Extensions.swift
//  MVVM IO
//
//  Created by Jaime Jazareno III on 1/14/21.
//  Copyright © 2021 Jaime Jazareno III. All rights reserved.
//

import RxSwift

extension Reactive where Base: UITextField {
    public var borderColor: Binder<CGColor> {
        return Binder(base, binding: { textField, active in
            textField.layer.borderColor = active
        })
    }
}
