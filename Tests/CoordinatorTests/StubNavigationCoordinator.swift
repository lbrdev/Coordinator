//
//  StubNavigationCoordinator.swift
//  
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import Coordinator
import Foundation
#if canImport(UIKit)
import UIKit
#endif

class StubNavigationCoordinator: NavigationCoordinator<StubMeta> {
    
    private func first() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
//        navigate(to: )
    }
    
    private func second() {
        
    }
}
