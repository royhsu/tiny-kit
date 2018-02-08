//
//  StateMachine.swift
//  TinyCore
//
//  Created by Roy Hsu on 20/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateMachine

public final class StateMachine<L: AnyObject> {

    public let eventManger = EventManager<StateMachineEvent, L>()

    public private(set) var currentState: State {

        didSet { eventManger.emit(.updateCurrentState) }

    }

    public init(initialState: State) { self.currentState = initialState }

}

extension StateMachine {

    func enter(_ state: State) throws {

        guard
            currentState.isValidNextState(state)
        else {

            let error: StateMachineError = .invalidNextState(state)

            throw error

        }

        currentState = state

    }

}
