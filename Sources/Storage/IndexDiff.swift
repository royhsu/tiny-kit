//
//  IndexDiff.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RxIndexDiff

import TinyCore

// TODO: move into TinyCore.
//public final class IndexDiff: ObservableProtocol {
//
//    public typealias Indices = [Int]
//
//    private final let _storage = Observable<Indices>()
//
//    public final var value: Indices? {
//
//        get { return _storage.value }
//
//        set { _storage.value = newValue }
//
//    }
//
//    public final func setValue(
//        _ value: Indices?,
//        options: ObservableValueOptions?
//    ) {
//
//        _storage.setValue(
//            value,
//            options: options
//        )
//
//    }
//
//    public final func subscribe(
//        with subscriber: @escaping Subscriber
//    )
//    -> ObservableSubscription { return _storage.subscribe(with: subscriber) }
//
//}

public typealias Indices = [Int]

public typealias IndexDiff = Observable<Indices>

public extension Observable where Value == Indices {

    public final var indices: Indices? {

        get { return value }

        set { value = newValue }

    }

    public final func setIndices(
        _ indices: Indices,
        options: ObservableValueOptions? = nil
    ) {

        setValue(
            indices,
            options: options
        )

    }

}
