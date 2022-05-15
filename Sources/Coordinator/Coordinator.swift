//
//  Coordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation

/// Base class to operate with flow using coordination pattern
open class Coordinator<M: CoordinationMeta>: NSObject {
    /// Property to store type-erased coordinators.
    ///
    /// Access can be reached by mutating functions.
    public internal(set) var coordinators: [AnyCoordinator] = []

    /// Meta avaliable only after `start(with:)`.
    /// Before that it's `nil`.
    public var meta: M!

    /// Callback that triggers after `finish()`.
    public var onFinish: ((Coordinator<M>) -> Void)?

    override public init() { super.init() }

    open func start(with meta: M) {
        self.meta = meta
    }

    open func finish() {
        self.onFinish?(self)
    }

    // MARK: - Operations with sub-coordinators

    /// Appends `coordinators` whith a new one.
    func add<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinator: C
    ) {
        coordinators.append(AnyCoordinator(coordinator))
    }

    /// Removes a coordiantor from `coordinators` using type.
    func remove<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinatorType: C.Type
    ) {
        coordinators.removeAll { type(of: $0.coordinator) == coordinatorType }
    }

    /// Removes a coordiantor from `coordinators` using coordinator instance.
    func remove<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinator: C
    ) {
        remove(type(of: coordinator))
    }

    /// Removes a coordiantor from `coordinators` using it's own meta.
    func remove<M: CoordinationMeta>(
        _ metaType: M.Type
    ) {
        coordinators.removeAll { $0.metaType == metaType }
    }

    /// Removes all coordiantors from `coordinators`.
    func removeAll() {
        coordinators.removeAll()
    }
}
