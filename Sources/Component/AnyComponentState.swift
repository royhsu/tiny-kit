//
//  AnyComponentState.swift
//  TinyKit
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyComponentState

import TinyCore

public struct AnyComponentState<CS: ComponentState>: ComponentState {

    private let base: CS

    public init(_ base: CS) { self.base = base }

    // MARK: State

    public func isValidNextState(_ state: State) -> Bool {

        return base.isValidNextState(state)

    }

    // MARK: Hashable

    public var hashValue: Int { return base.hashValue }

    // MARK: Equatable

    public static func ==(
        lhs: AnyComponentState<CS>,
        rhs: AnyComponentState<CS>
    )
    -> Bool { return lhs.base == rhs.base }

}
