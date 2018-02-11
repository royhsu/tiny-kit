//
//  StubStateMachineListener.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StubStateMachineListener

import TinyCore

internal final class StubStateMachineListener {

    internal typealias DidUpdateCurrentState = (Event) -> Void

    internal let didUpdateCurrentState: DidUpdateCurrentState?

    internal init(
        didUpdateCurrentState: DidUpdateCurrentState? = nil
    ) { self.didUpdateCurrentState = didUpdateCurrentState }

    internal func handleUpdateCurrentState(_ event: Event) { didUpdateCurrentState?(event) }

}
