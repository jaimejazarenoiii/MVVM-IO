//
//  ApplicationCoordinator.swift
//  MVVM IO
//
//  Created by Jaime Jazareno III on 1/13/21.
//  Copyright © 2021 Jaime Jazareno III. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

/// Class for coordinating view controllers and do the navigations
class ApplicationCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewModel = SigninViewModel()
        let viewController = SigninViewController(viewModel: viewModel)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
