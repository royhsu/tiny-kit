//
//  State.swift
//  TinyCore
//
//  Created by Roy Hsu on 20/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - State

public protocol State {

    func isValidNextState(_ state: State) -> Bool

}
