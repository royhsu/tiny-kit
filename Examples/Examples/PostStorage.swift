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
    
    private final let _storage = MemoryCache<Int, Value>()
    
    public init() { }
    
    public final var keyDiff: Observable< Set<Int> > { return _storage.keyDiff }
    
    public final var pairs: AnyCollection< (key: Int, value: Value) > {
        
        return AnyCollection(
            _storage.pairs.sorted { $0.key < $1.key }
        )
        
    }
    
    public final func setPairs(_ pairs: AnyCollection< (key: Int, value: Value?) >) { _storage.setPairs(pairs) }
    
}
