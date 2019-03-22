//
//  FormField+Observable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Observable

import TinyCore

extension FormField: Observable {
    
    public func observe(
        on queue: DispatchQueue = .global(),
        observer: @escaping (Property<Value>.ObservedChange) -> Void
    )
    -> Observation { return _storage.observe(on: queue, observer: observer) }

}
