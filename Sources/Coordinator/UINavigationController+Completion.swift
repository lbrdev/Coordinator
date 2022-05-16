//
//  UINavigationController+Completion.swift
//
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import UIKit

extension UINavigationController {
    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func popViewController(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }

    func popToRootViewController(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }

    public func popToViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
