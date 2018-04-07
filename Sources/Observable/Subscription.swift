//
//  Subscription.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Subscription

public final class Subscription<T> {
    
    public typealias Subscriber = (
        _ oldValue: T,
        _ newValue: T
    )
    -> Void
    
    public let subscriber: Subscriber
    
    public init(subscriber: @escaping Subscriber) { self.subscriber = subscriber }
    
}
