//
//  AnyCoordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation

/// Type erasure for `Coordinator`
public class AnyCoordinator {
    let coordinator: Any
    var metaType: CoordinationMeta.Type?
    let id: String

    init<M: CoordinationMeta, C: Coordinator<M>>(_ coordinator: C) {
        self.coordinator = coordinator
        metaType = M.self
        id = String(describing: C.self)
    }
}

extension AnyCoordinator: Equatable, Hashable {
    public static func == (lhs: AnyCoordinator, rhs: AnyCoordinator) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
