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
            
            // Clean up the dead objects.
            weakObjects = weakObjects.filter { $0.reference != nil }
            
            weakObjects.forEach { object in
                
                let subscriber = object.reference?.subscriber
                
                subscriber?(
                    oldValue,
                    newValue
                )
                
            }
            
        }
        
    }
    
    public typealias AnySubscription = Subscription<T>
    
    public typealias AnySubscriber = AnySubscription.Subscriber
    
    private final var weakObjects: [WeakObject<AnySubscription>] = []
    
    public init(_ value: T) { self.value = value }
    
}

public extension Observable {
    
    /// A subscriber must keep the strong reference to the subscription while observing.
    /// Unsubscribing is easy. Just set the reference of the subscription to nil.
    public final func subscribe(with subscriber: @escaping AnySubscriber) -> AnySubscription {
        
        let subscription = Subscription(
            token: UUID().uuidString,
            subscriber: subscriber
        )
        
        weakObjects.append(
            WeakObject(subscription)
        )
        
        return subscription
        
    }
    
}
