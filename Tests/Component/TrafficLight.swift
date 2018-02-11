//
//  TrafficLight.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TrafficLight

import TinyCore

internal enum TrafficLight: String {

    case green, yellow, red

}

extension TrafficLight: State {

    internal func isValidNextState(_ state: State) -> Bool {

        guard
            let next = state as? TrafficLight
            else { return false }

        let old = self

        switch (old, next) {

        case
        (.green, .yellow),
        (.yellow, .red),
        (.red, .green):
            return true

        default: return false
        }

    }

}
