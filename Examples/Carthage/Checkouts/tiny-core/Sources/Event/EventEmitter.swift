//
//  EventEmitter.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - EventEmitter

public protocol EventEmitter {

    func emit(_ event: Event)

}

// MARK: - AnyEventEmitter

public struct AnyEventEmitter<Listener: AnyObject>: EventEmitter {

    public typealias Emit = (Listener) -> (Event) -> Void

    private weak var _listener: Listener?

    private let _emit: Emit

    public init(
        listener: Listener,
        emit: @escaping Emit
    ) {

        self._listener = listener

        self._emit = emit

    }

    public func emit(_ event: Event) {

        guard
            let listener = _listener
        else { return }

        _emit(listener)(event)

    }

}
