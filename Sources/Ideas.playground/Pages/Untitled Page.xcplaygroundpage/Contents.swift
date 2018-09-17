import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

//class APICache<Value>: Storage where Value: Decodable {
//
//    typealias Index = Int
//
//    typealias Indices = [Index]
//
//    let remote: Remote
//
//    private var fetchingIndices = Set<Index>()
//
//    private let _memoryCache = MemoryCache<Index, Value>()
//
//    init(remote: Remote) { self.remote = remote }
//
//    var keyDiff: Observable<Indices> { return _memoryCache.keyDiff }
//
//    var maxKey: Index? { return _memoryCache.maxKey }
//
//    subscript(_ index: Index) -> Value? {
//
//        if let cachedValue = _memoryCache[index] { return cachedValue }
//
//        if fetchingIndices.contains(index) { return nil }
//
//        fetchingIndices.insert(index)
//
//        remote.fetchItems { [weak self] (result: Result<[Value]>) in
//
//            self?.fetchingIndices.remove(index)
//
//            guard
//                let self = self,
//                let values = try? result.resolve()
//            else { return }
//
//            let keyValuePairs = values.enumerated().map { ($0.offset, $0.element) }
//
//            let dictionary = Dictionary(
//                keyValuePairs,
//                uniquingKeysWith: { first, _ in first }
//            )
//
//            dictionary.keys.forEach { index in
//
//                self.fetchingIndices.remove(index)
//
//            }
//
//            self._memoryCache.setKeyValuePairs(dictionary)
//
//            guard
//                let fetchingMinIndex = self.fetchingIndices.min(),
//                let fetchedLastIndex = self.maxKey
//            else { return }
//
//            let shouldFetchMoreItems = (fetchingMinIndex > fetchedLastIndex)
//
//            if shouldFetchMoreItems {
//
//                print("Still have some unfetched.", self.fetchingIndices)
//
//            }
//
//        }
//
//        return nil
//
//    }
//
//}

//class Cache: Storage {
//
//    typealias Index = Int
//
//    let indexDiff = IndexDiff()
//
//    private var _storage: [String?] = []
//
//    var count: Int { return _storage.count }
//
//    subscript(_ index: Index) -> String? {
//
//        get {
//
//            if index >= _storage.count { return nil }
//
//            return _storage[index]
//
//        }
//
//        set {
//
//            let currentLastIndex = _storage.count
//
//            let newLastIndex = index + 1
//
//            let unallocatedCount = newLastIndex - currentLastIndex
//
//            if unallocatedCount > 0 {
//
//                _storage.append(
//                    contentsOf: Array(
//                        repeating: nil,
//                        count: unallocatedCount
//                    )
//                )
//
//            }
//
//            _storage[index] = newValue
//
//            indexDiff.value = [ index ]
//
//        }
//
//    }
//
//    func setValues(_ values: [String?]) {
//
//        _storage = values
//
//        indexDiff.value = values.indices.map { $0 }
//
//    }
//
//}

//class StorageCoordinator: Storage {
//
//    private(set) var count: Int = 0
//
//    let indexDiff = IndexDiff()
//
//    typealias Index = Int
//
//    var storages: [Storage] = [] {
//
//        didSet {
//
//            subscriptions = storages.map { storage in
//
//                return storage.indexDiff.subscribe { event in
//
//                    defer { self.indexDiff.value = event.currentValue }
//
//                    guard
//                        let indices = event.currentValue,
//                        let lastIndex = indices.max()
//                    else { return }
//
//                    let currentCount = self.count
//
//                    self.count = max(
//                        currentCount,
//                        lastIndex + 1
//                    )
//
//                }
//
//            }
//
//        }
//
//    }
//
//    private var subscriptions: [ObservableSubscription] = []
//
//    subscript(_ index: Index) -> String? {
//
//        let storage = storages.first { $0[index] != nil }
//
//        return storage?[index]
//
//    }
//
//}

PlaygroundPage.current.needsIndefiniteExecution = true

print("End")
