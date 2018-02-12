//
//  ProfileComponentState.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileComponentState

public enum ProfileComponentState: String {

    case initial, loading, loaded, error

}

// MARK: - State

import TinyCore

extension ProfileComponentState: State {

    public func isValidNextState(_ state: State) -> Bool {

        guard
            let new = state as? ProfileComponentState
        else { return false }

        let old = self

        switch (old, new) {

        case
            (.initial, .loading),
            (.loading, .loaded),
            (.loading, .error),
            (.loaded, .loading),
            (.error, .loading):

            return true

        default: return false

        }

    }

}
