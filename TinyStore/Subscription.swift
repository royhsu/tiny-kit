//
//  Subscription.swift
//  TinyStore
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
    
    public let token: String
    
    public let subscriber: Subscriber
    
    public init(
        token: String,
        subscriber: @escaping Subscriber
    ) {
        
        self.token = token
        
        self.subscriber = subscriber
        
    }
    
}
