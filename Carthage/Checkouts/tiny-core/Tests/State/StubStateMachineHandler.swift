//
//  StubStateMachineHandler.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StubStateMachineHandler

import TinyCore

internal final class StubStateMachineHandler: StateMachineDelegate {

    internal typealias DidChangeStateFromOldToNew = (_ old: State, _ new: State) -> Void

    internal let didChangeStateFromOldToNew: DidChangeStateFromOldToNew?

    internal init(
        didChangeStateFromOldToNew: DidChangeStateFromOldToNew? = nil
    ) { self.didChangeStateFromOldToNew = didChangeStateFromOldToNew }

    internal final func stateMachine(
        _ stateMachine: StateMachine,
        didChangeFrom old: State,
        to new: State
    ) { didChangeStateFromOldToNew?(old, new) }

}
