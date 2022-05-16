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

    /// - Important: Avaliable only after `start(with:)`.
    /// Before that it's `nil`.
    public var meta: M!

    /// Callback that triggers after `finish()`.
    public var onFinish: ((Coordinator<M>) -> Void)?

    public internal(set) var parent: AnyCoordinator?

    open var debug: Bool { return false }

    override public init() { super.init() }

    deinit {
        if debug {
            print("Deinit coordinator \(String(describing: self))")
        }
    }

    open func start(with meta: M) {
        self.meta = meta
    }

    open func finish() {
        onFinish?(self)
    }

    // MARK: - Operations with sub-coordinators

    /// Appends `coordinators` whith a new one.
    public func add<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinator: C
    ) {
        coordinators.append(coordinator.asAny)
        coordinator.parent = asAny
    }

    /// Removes a coordiantor from `coordinators` using type.
    public func remove<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinatorType: C.Type
    ) {
        coordinators.removeAll { type(of: $0.coordinator) == coordinatorType }
    }

    /// Removes a coordiantor from `coordinators` using coordinator instance.
    public func remove<M: CoordinationMeta, C: Coordinator<M>>(
        _ coordinator: C
    ) {
        remove(type(of: coordinator))
    }

    /// Removes a coordiantor from `coordinators` using it's own meta.
    public func remove<M: CoordinationMeta>(
        _ metaType: M.Type
    ) {
        coordinators.removeAll { $0.metaType == metaType }
    }

    public func remove(_ anyCoordinator: AnyCoordinator) {
        coordinators.removeAll { $0.metaType == anyCoordinator.metaType }
    }

    /// Removes all coordiantors from `coordinators`.
    public func removeAll() {
        coordinators.removeAll()
    }
}
