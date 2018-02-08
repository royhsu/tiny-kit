//
//  StateMachineError.swift
//  TinyCore
//
//  Created by Roy Hsu on 20/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateMachineError

public enum StateMachineError: Error {

    case invalidNextState(State)

}
