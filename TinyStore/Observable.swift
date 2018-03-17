//
//  Observable.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//
// MARK: - Observable

public final class Observable<T> {
    
    public final var value: T {
        
        didSet {
            
            let newValue = value
            
            subscriberMap.values.forEach { subscriber in
                
                subscriber(
                    oldValue,
                    newValue
                )
                
            }
            
        }
        
    }
    
    public typealias Subscriber = (
        _ oldValue: T,
        _ newValue: T
    )
    -> Void
    
    private final var subscriberMap: [Subscription: Subscriber] = [:]
    
    public init(_ value: T) { self.value = value }
    
}

import Foundation

extension Observable {
    
    @discardableResult
    public final func subscribe(with subscriber: @escaping Subscriber) -> Subscription {
    
        let subscription = Subscription(
            token: UUID().uuidString
        )
    
        subscriberMap[subscription] = subscriber
        
        return subscription
        
    }
    
    public final func unsubscribe(for subscription: Subscription) { subscriberMap[subscription] = nil }
    
}
