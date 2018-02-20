//
//  UIProfileState.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileState

import TinyCore

public enum UIProfileState: State {

    case initial

    case loading

    case loaded(user: User, posts: [Post])

    case error(Error)

    // MARK: State

    public func isValidNextState(_ state: State) -> Bool {

        let old = self

        guard
            let new = state as? UIProfileState
            else { return false }

        switch (old, new) {

        case
            (.initial, .loading),
            (.loading, .loaded),
            (.loaded, .loading),
            (.loading, .error):

            return true

        default: return false

        }

    }

}
