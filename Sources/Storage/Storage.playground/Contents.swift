import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

struct Post: Codable {
    
    let id: Int
    
    let title: String
    
}

class APIService {
    
    let client: HTTPClient
    
    init(client: HTTPClient) { self.client = client }
    
    func fetchPost(
        id: String,
        completionHandler: @escaping (Result<Post>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completionHandler: completionHandler
        )
        
    }
    
    func fetchPosts(
        completionHandler: @escaping (Result<[Post]>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completionHandler: completionHandler
        )
        
    }
    
}

protocol Remote {
    
    func fetchItems<Item: Decodable>(
        completionHandler: @escaping (Result<[Item]>) -> Void
    )
    
}

//struct AnyStorage<Key, Value> where Key: Hashable & Comparable {
//
//    var keyDiff: Observable<[Key]>
//
//    var maxKey: Key?
//
//    init<S: Storage>(_ storage: S) where S.Key == Key, S.Value == Value {
//
//        self.keyDiff = storage.keyDiff
//
//        self.maxKey = storage.maxKey
//
//    }
//
//}

extension APIService: Remote {
    
    func fetchItems<Item>(
        completionHandler: @escaping (Result<[Item]>) -> Void
    )
    where Item: Decodable {
        
        fetchPosts { result in
            
            do {
            
                let items: [Item] = try result.resolve().map { $0 as! Item }
                
                completionHandler(
                    .success(items)
                )
                
            }
            catch {
                
                completionHandler(
                    .failure(error)
                )
                
            }
            
        }
        
    }
    
}

class APICache<Value>: Storage where Value: Decodable {

    typealias Index = Int

    typealias Indices = [Index]

    let remote: Remote
    
    private var fetchingIndices = Set<Index>()

    private let _memoryCache = MemoryCache<Index, Value>()

    init(remote: Remote) { self.remote = remote }

    var keyDiff: Observable<Indices> { return _memoryCache.keyDiff }

    var maxKey: Index? { return _memoryCache.maxKey }

    subscript(_ index: Index) -> Value? {
        
        if let cachedValue = _memoryCache[index] { return cachedValue }
    
        if fetchingIndices.contains(index) { return nil }
        
        fetchingIndices.insert(index)
        
        remote.fetchItems { [weak self] (result: Result<[Value]>) in
            print("After fetching...")
            self?.fetchingIndices.remove(index)
            
            guard
                let self = self,
                let values = try? result.resolve()
            else { return }
            
            let keyValuePairs = values.enumerated().map { ($0.offset, $0.element) }
            
            let dictionary = Dictionary(
                keyValuePairs,
                uniquingKeysWith: { first, _ in first }
            )
            
            dictionary.keys.forEach { index in
             
                self.fetchingIndices.remove(index)
                
            }
            
            self._memoryCache.setKeyValuePairs(dictionary)
            
            guard
                let fetchingLastIndex = self.fetchingIndices.max(),
                let fetchedLastIndex = self.maxKey
            else { return }
            
            let shouldFetchMoreItems = (fetchingLastIndex > fetchedLastIndex)
            
            if shouldFetchMoreItems {
                
                print("Still have some unfetched.", self.fetchingIndices)
                
            }
            
        }
        
        return nil
    
    }
    
}

let service = APIService(client: URLSession.shared)

//service.fetchPost(id: "1") { result in
//
//    print(result)
//
//}

//service.fetchPosts { result in
//
//    print(result)
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
//
//class Dummy: Storage {
//
//    private struct Content { }
//
//    let indexDiff = IndexDiff()
//
//    typealias Index = Int
//
//    private var _storage: [Content] = []
//
//    var count: Int { return _storage.count }
//
//    subscript(_ index: Int) -> String? {
//
//        get { return "Loading..." }
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
//                        repeating: Content(),
//                        count: unallocatedCount
//                    )
//                )
//
//            }
//
//            indexDiff.value = [ index ]
//
//        }
//
//    }
//
//}
//
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

//typealias Cache = MemoryCache<Int, String>

let viewController = TableViewController<APICache<Post>>()

let apiCache = APICache<Post>(
    remote: APIService(client: URLSession.shared)
)

viewController.storage = apiCache
//
//let _ = apiCache.keyDiff.subscribe { event in
//
//    print("API Cache:", event.currentValue)
//
//}
//
//let first = apiCache[0]
//
//print(first)

//let coordinator = StorageCoordinator()

//coordinator.storages.append(
//    contentsOf: [
//        cache,
//        dummy
//    ] as [Storage]
//)

//viewController.storage = coordinator

PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

//    cache.setKeyValuePairs(
//        [
//            0: "Hello",
//            1: "World",
//            7: "QQ"
//        ]
//    )

}

print("End")

PlaygroundPage.current.needsIndefiniteExecution = true
