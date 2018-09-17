//
//  PostStorage.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostStorage

import TinyCore
import TinyKit

public final class PostStorage: Storage {
    
    public enum Value {
        
        case post(Post)
        
        case comment(Comment)
        
    }
    
    private final var storage: AnyStorage<Int, Value> {
        
        return AnyStorage(_memoryStorage)
        
    }
    
    private final let _memoryStorage = MemoryCache<Int, Value>()
    
    private final var _apiManager: APIManager<Post>?
    
    private final var subscriptions: [ObservableSubscription] = []
    
    public init(resource: PostResource? = nil) {
        
        if let resource = resource {
            
            let manager = APIManager(resource: resource)
            
            let subscription = manager.keyDiff.subscribe { event in
                
                let pairs: [ (key: Int, value: Value?) ] = manager.pairs.map { pair in
                    
                    return (
                        pair.key,
                        Value.post(pair.value)
                    )
                    
                }
                
                self._memoryStorage.setPairs(
                    AnyCollection(pairs)
                )
                
            }
            
            subscriptions.append(subscription)
            
            _apiManager = manager
            
        }
        
    }
    
    public final func load() { _apiManager?.load() }
    
    public final var keyDiff: Observable< Set<Int> > { return storage.keyDiff }
    
    public final var pairs: AnyCollection< (key: Int, value: Value) > {
        
        return AnyCollection(
            storage.pairs.sorted { $0.key < $1.key }
        )
        
    }
    
    public final func setPairs(_ pairs: AnyCollection< (key: Int, value: Value?) >) { storage.setPairs(pairs) }
    
}
