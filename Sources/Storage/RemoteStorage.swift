//
//  RemoteStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RemoteStorage

import TinyCore

public final class RemoteStorage<Item>: MutableStorage where Item: Decodable {
    
    private enum State {
     
        case initial, loading, loaded
        
    }
    
    public typealias Change = StorageChange<Int, Item>
    
    public typealias Changes = Set<Change>
    
    public typealias Cache = MemoryCache<Int, Item>
    
    public typealias Element = Cache.Element
    
    public typealias Index = Cache.Index
    
    private final let resource: AnyResource<Item>

    public final var changes: Observable<Changes> { return cache.changes }
    
    private final var cache = Cache()

    private final var state: State = .initial
    
    public final var isLoaded: Bool { return state == .loaded }
    
    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }

    public final var startIndex: Index { return cache.startIndex }
    
    public final var endIndex: Index { return cache.endIndex }
    
    public final func index(after i: Index) -> Index { return cache.index(after: i) }
    
    public final subscript(position: Index) -> Element { return cache[position] }
    
    /// The storage will try to fetch items from the given resource if there is no value related to the key.
    #warning("Not implemented.")
    public final func value(
        forKey key: Int,
        completion: @escaping (Result<Item>) -> Void
    ) {
        
//        if let value = cache[key] {
//
//            completion(
//                .success(value)
//            )
//
//            return
//
//        }
//
//        load { result in
//
//            switch result {
//
//            }
//
//        }
        
    }
    
    public func setValue(
        _ value: Value?,
        forKey key: Key,
        options: ObservableValueOptions = []
    ) {
        
         cache.setValue(
            value,
            forKey: key,
            options: options
        )
        
    }
    
    #warning("missing test.")
    public final func removeAll() { cache = [:] }
    
    public final func load(completion: LoadCompletion? = nil) {
        
        state = .loading
        
        resource.fetchItems(page: .first) { [weak self] result in
            
            defer { self?.state = .loaded }
            
            guard
                let self = self
            else { return }
            
            switch result {
                
            case let .success(payload):
            
                let sequence: [ (key: Key, value: Item?) ] = payload
                    .items
                    .enumerated()
                    .map { $0 }
                
                self.cache.removeAll(options: .muteBroadcaster)
                
                self.cache.merge(
                    AnySequence(sequence)
                )
                
                completion?(
                    .success(
                        Void()
                    )
                )
                
            case let .failure(error):
                
                completion?(
                    .failure(error)
                )
            
            }
            
        }
        
    }
    
    #warning("missing test.")
    public final func merge(
        _ other: AnySequence< (key: Key, value: Value?) >,
        options: ObservableValueOptions = []
    ) {
     
        cache.merge(
            other,
            options: options
        )
            
    }
    
    #warning("Not implemented.")
    public final func removeAll(
        options: ObservableValueOptions = []
    ) {
        
        
        
    }

}
