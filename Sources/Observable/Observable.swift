//
//  Observable.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Observable

public final class Observable<T> {
    
    public final var value: T {
        
        willSet {
            
            let oldValue = value
            
            // Clean up the dead objects.
            valueWillChangeObjects = valueWillChangeObjects.filter { $0.reference != nil }
            
            valueWillChangeObjects.forEach { object in
                
                object.reference?.subscriber(
                    oldValue,
                    newValue
                )
                
            }
            
        }
        
        didSet {
            
            let newValue = value
            
            // Clean up the dead objects.
            valueDidChangeObjects = valueDidChangeObjects.filter { $0.reference != nil }
            
            valueDidChangeObjects.forEach { object in
                
                object.reference?.subscriber(
                    oldValue,
                    newValue
                )
                
            }
            
        }
        
    }
    
    public init(_ value: T) {
        
        self.value = value
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        initialValueObjects.forEach { [unowned self] object in
            
            object.reference?.subscriber(self.value)
            
        }

        // Remove all the initial value subscriptions that will only be notified once.
        initialValueObjects = []
        
    }
    
    // MARK: InitialValueSubscriber
    
    public typealias InitialValueSubscriber = (_ value: T) -> Void
    
    // MARK: InitialValueSubscription
    
    public final class InitialValueSubscription {
        
        public let subscriber: InitialValueSubscriber
        
        public init(subscriber: @escaping InitialValueSubscriber) { self.subscriber = subscriber }
        
    }
    
    private final var initialValueObjects: [WeakObject<InitialValueSubscription>] = []
    
    // MARK: ValueWillChangeSubscriber
    
    public typealias ValueWillChangeSubscriber = (
        _ oldValue: T,
        _ newValue: T
    )
    -> Void
    
    // MARK: ValueWillChangeSubscription
    
    public final class ValueWillChangeSubscription {
        
        public let subscriber: ValueWillChangeSubscriber
        
        public init(subscriber: @escaping ValueWillChangeSubscriber) { self.subscriber = subscriber }
        
    }
    
    private final var valueWillChangeObjects: [WeakObject<ValueWillChangeSubscription>] = []
    
    // MARK: ValueDidChangeSubscriber
    
    public typealias ValueDidChangeSubscriber = (
        _ oldValue: T,
        _ newValue: T
    )
    -> Void
    
    // MARK: ValueDidChangeSubscription
    
    public final class ValueDidChangeSubscription {
        
        public let subscriber: ValueDidChangeSubscriber
        
        public init(subscriber: @escaping ValueDidChangeSubscriber) { self.subscriber = subscriber }
        
    }
    
    private final var valueDidChangeObjects: [WeakObject<ValueDidChangeSubscription>] = []
    
}

public extension Observable {
    
    /// A subscriber must keep the strong reference to the subscription while observing.
    /// Unsubscribing is easy. Just set the reference of the subscription to nil.
    
    public final func observeInitialValue(subscriber: @escaping InitialValueSubscriber) -> InitialValueSubscription {
        
        let subscription = InitialValueSubscription(subscriber: subscriber)

        initialValueObjects.append(
            WeakObject(subscription)
        )

        return subscription
        
    }
    
    public final func observeValueWillChange(subscriber: @escaping ValueWillChangeSubscriber) -> ValueWillChangeSubscription {
        
        let subscription = ValueWillChangeSubscription(subscriber: subscriber)

        valueWillChangeObjects.append(
            WeakObject(subscription)
        )

        return subscription
        
    }
    
    public final func observeValueDidChange(subscriber: @escaping ValueDidChangeSubscriber) -> ValueDidChangeSubscription {
        
        let subscription = ValueDidChangeSubscription(subscriber: subscriber)

        valueDidChangeObjects.append(
            WeakObject(subscription)
        )

        return subscription
        
    }
    
}
