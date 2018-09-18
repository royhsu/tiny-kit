//
//  APIManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIManager

import TinyCore

//public final class APIManager<Item>: Storage where Item: Decodable {
//
//    private final let resource: AnyResource<Item>
//
//    private final let _storage = MemoryCache<Int, Item>()
//
//    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }
//
//    public final func removeAll() { _storage.setPairs(.empty) }
//
//    public final func load() {
//
//        resource.fetchItems(page: .first) { [weak self] result in
//
//            guard
//                let self = self,
//                let payload = try? result.resolve()
//            else { return }
//
//            self.setValues(payload.items)
//
//        }
//
//    }
//
//    public final var keyDiff: Observable< Set<Int> > { return  _storage.keyDiff }
//
//    public final var pairs: AnyCollection<(key: Int, value: Item)> {
//
//        let pairs = _storage.pairs
//
////        _storage.
//
//        return pairs
//
//    }
//
//    /// Only accepting the first value for a key and ignoring the rest of values for the same key.
//    public final func setPairs(_ pairs: AnyCollection<(key: Int, value: Item?)>) { _storage.setPairs(pairs) }
//
//}
//
//public extension AnyCollection {
//
//    public static var empty: AnyCollection { return AnyCollection( [] ) }
//
//}
