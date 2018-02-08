//
//  DoorState.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - DoorState

import TinyCore

internal enum DoorState: State {

    case close, open

    internal func isValidNextState(_ state: State) -> Bool {

        let old = self

        guard
            let new = state as? DoorState
        else { return false }

        switch (old, new) {

        case
            (.close, .open),
            (.open, .close): return true

        default: return false

        }

    }

}
