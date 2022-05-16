//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import Coordinator
import UIKit

struct AppMeta: CoordinationMeta {}

class AppCoordinator: NavigationCoordinator<AppMeta> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }

    override func start(with meta: AppMeta) {
        super.start(with: meta)

        let root = RootViewController()
        navigate(to: .set([root]))
        root.push = { [unowned self] in
            self.startSecondPush()
        }
        
        root.present = { [unowned self] in
            self.startSecondPresent()
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func startSecondPush() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        add(secondCoordinator)
        secondCoordinator.start(with: .firstState)
    }
    
    private func startSecondPresent() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        add(secondCoordinator)
        secondCoordinator.start(with: .secondState)
    }
}
