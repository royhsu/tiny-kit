//
//  StateMachine.swift
//  TinyCore
//
//  Created by Roy Hsu on 20/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateMachineDelegate

public protocol StateMachineDelegate: class {

    func stateMachine(
        _ stateMachine: StateMachine,
        didChangeFrom old: State,
        to new: State
    )

}

// MARK: - StateMachine

public final class StateMachine {

    public private(set) final var currentState: State {

        didSet {

            delegate?.stateMachine(
                self,
                didChangeFrom: oldValue,
                to: currentState
            )

        }

    }

    public final weak var delegate: StateMachineDelegate?

    public init(initialState: State) { self.currentState = initialState }

}

public extension StateMachine {

    public final func enter(_ state: State) {

        guard
            currentState.isValidNextState(state)
        else { fatalError("Invalid state transition from \(currentState) to \(state).") }

        currentState = state

    }

}
