//
//  MemoryCache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCache

import TinyCore

public final class MemoryCache<Key, Value>: MutableStorage, Initializable, ExpressibleByDictionaryLiteral where Key: Hashable {
    
    private enum State {
        
        case initial, loaded
        
    }
    
    public typealias Storage = Dictionary<Key, Value>
    
    public typealias Element = Storage.Element
    
    public typealias Change = StorageChange<Key, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Index = Storage.Index
    
    private final var _storage: Storage
    
    public required init() { self._storage = [:] }
    
    public required init(dictionaryLiteral elements: (Key, Value)...) {
     
        self._storage = Storage(uniqueKeysWithValues: elements)
        
        changes.value = Set(
            elements.map(StorageChange.init)
        )
        
    }
    
    public final let changes = Observable<Changes>()
    
    private final var state: State = .initial

    public final var isLoaded: Bool { return state == .loaded }
    
    public final var startIndex: Index { return _storage.startIndex }
    
    public final var endIndex: Index { return _storage.endIndex }
    
    public final func index(after i: Index) -> Index { return _storage.index(after: i) }
    
    public final subscript(position: Index) -> Element { return _storage[position] }
    
    public final func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        #warning("should prevent accessing before loaded.")
        
        guard
            let value = self[key]
        else {
            
            let error: StorageError<Key> = .valueNotFound(key: key)
            
            return completion(
                .failure(error)
            )
            
        }
        
        completion(
            .success(value)
        )
        
    }
    
    public final func load(completion: LoadCompletion? = nil) {
        
        state = .loaded
        
        completion?(
            .success(
                Void()
            )
        )
        
    }
    
    #warning("missing test with options.")
    public func setValue(
        _ value: Value?,
        forKey key: Key,
        options: ObservableValueOptions = []
    ) {
        
        #warning("should prevent accessing before loaded.")
        
        _storage[key] = value
        
        if options.contains(.muteBroadcaster) { return }
        
        changes.value = [
            Change(
                key: key,
                value: value
            )
        ]
        
    }
    
    #warning("missing test with options.")
    public final func merge(
        _ other: AnySequence< (key: Key, value: Value?) >,
        options: ObservableValueOptions = []
    ) {
        
        #warning("should prevent accessing before loaded.")
        
        var mergingElements: [ (Key, Value) ] = []
        
        var removingKeys: [Key] = []
            
        var updatingElements: [ (key: Key, value: Value) ] = []
        
        for element in other {
            
            let key = element.key
            
            if let newValue = element.value {
                
                mergingElements.append(
                    (key, newValue)
                )
                
                updatingElements.append(
                    (key, newValue)
                )
                
            }
            else {
                
                if let existingValue = self[key] {
                    
                    updatingElements.append(
                        (key, existingValue)
                    )
                    
                }
                else { removingKeys.append(key) }
                
            }
            
        }
        
        removingKeys.forEach { self._storage.removeValue(forKey: $0) }

        _storage.merge(
            mergingElements,
            uniquingKeysWith: { _, new in new }
        )
        
        changes.setValue(
            Set(
                updatingElements.map(StorageChange.init)
            ),
            options: options
        )
        
    }
    
}
