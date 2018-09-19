//
//  Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Storage

import TinyCore

public protocol Storage: Collection where Element == (key: Key, value: Value) {

    associatedtype Key: Hashable
    
    associatedtype Value
    
    subscript(key: Key) -> Value? { get }
    
    func value(
        forKey key: Key,
        completion: (Result<Value>) -> Void
    )
    
}

// MARK: - Default Implementation

public extension Storage {
    
    public subscript(key: Key) -> Value? {
        
        guard
            let element = first(
                where: { $0.key == key }
            )
        else { return nil }
        
        return element.value
        
    }
    
}

//public extension Storage where Key == Int {
//    
//    // TODO: should define a better name. setIndexedValues
//    public func setValues(
//        _ values: [Value?],
//        options: ObservableValueOptions? = nil
//    ) {
//        
//        let pairs = values.enumerated().map { ($0.offset, $0.element) }
//        
//        setPairs(
//            AnyCollection(pairs),
//            options: options
//        )
//        
//    }
//    
//    /// The count of stored pairs.
//    public var count: Int { return pairs.count }
//    
//    public var isEmpty: Bool { return pairs.isEmpty }
//    
//    public subscript(key: Key) -> Value? {
//        
//        get { return pairs.first { $0.key == key }?.value }
//        
//        set {
//            
//            setPairs(
//                AnyCollection(
//                    [
//                        (key, newValue)
//                    ]
//                ),
//                options: nil
//            )
//            
//        }
//        
//    }
//    
//}
