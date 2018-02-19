//
//  UIProfileState.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileState

public enum UIProfileState: State {

    case initial, loading, loaded

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
            (.loaded, .loading):

            return true

        default: return false

        }

    }

}
