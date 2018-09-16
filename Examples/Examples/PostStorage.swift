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
    
    private typealias Storage = MemoryCache<Int, Value>
    
    private final var _storage = Storage()
    
    public init() { }
    
    public final var keyDiff: Observable<[Int]> { return _storage.keyDiff }
    
    public final var pairs: AnyCollection<(key: Int, value: Value)> {
        
        return AnyCollection(
            _storage.pairs.lazy.sorted { $0.key < $1.key }
        )
        
    }
    
    public final func setPairs(_ pairs: AnyCollection<(key: Int, value: Value)>) { _storage.setPairs(pairs) }
    
}
