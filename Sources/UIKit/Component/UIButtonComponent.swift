//
//  ButtonComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITouchEvent

public enum UITouchEvent: String, Hashable {
    
    case touchUpInside
    
}

// MARK: - UIButtonComponent

public protocol UIButtonComponent: Component {
    
    var eventEmitter: NewEventEmitter<UITouchEvent> { get }
    
}

// MARK: - EventEmitter

import TinyCore

// TODO: move into TinyCore.
public final class NewEventEmitter<Event> where Event: Hashable {
    
    public typealias Listener = (_ event: Event) -> Void
    
    public final class Listening {
        
        internal let listener: Listener
        
        internal init(listener: @escaping Listener) { self.listener = listener }
        
    }
    
    public typealias WeakListenings = [WeakObject<Listening>]
    
    private final var listeningMap: [Event: WeakListenings]
    
    public init() { listeningMap = [:] }
    
}

public extension NewEventEmitter {
    
    public final func emit(event: Event) {
        
        // Clean up the dead objects.
        listeningMap[event] = listeningMap[event]?.filter { $0.reference != nil }
        
        listeningMap[event]?.forEach { listening in listening.reference?.listener(event) }
        
    }
    
}

public extension NewEventEmitter {
    
    /// A listener must keep the strong reference to the listening while observing.
    /// Removing listener is easy. Just set the reference of the listening to nil.
    
    public final func listen(
        event: Event,
        listener: @escaping Listener
    )
    -> Listening {
        
        let listening = Listening(listener: listener)
        
        var listenings = listeningMap[event] ?? []
        
        listenings.append(
            WeakObject(listening)
        )
        
        listeningMap[event] = listenings
        
        return listening
        
    }
    
}
