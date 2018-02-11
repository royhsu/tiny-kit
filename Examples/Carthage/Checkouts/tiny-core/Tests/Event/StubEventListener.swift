//
//  StubEventListener.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StubEventListener

import TinyCore

internal final class StubEventListener {

    internal typealias DidTouchUpInside = (Event) -> Void

    internal let didTouchUpInside: DidTouchUpInside?

    internal init(
        didTouchUpInside: DidTouchUpInside? = nil
    ) { self.didTouchUpInside = didTouchUpInside }

    internal func handleTouchUpInside(_ event: Event) { didTouchUpInside?(event) }

}
