import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

public struct Post: Codable, Equatable {
    
    let id: Int
    
    let title: String
    
    let body: String
    
}

class PostResource {
    
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

extension PostResource: Resource {
    
    func fetchItems(
        page: Page,
        completionHandler: @escaping (Result<FetchItemsPayload<Post>>) -> Void
    ) {
        
        fetchPosts { result in
            
            switch result {
                
            case let .success(posts):
                
                completionHandler(
                    .success(
                        FetchItemsPayload(items: posts)
                    )
                )
                
            case let .failure(error):
                
                completionHandler(
                    .failure(error)
                )
                
            }
            
        }
        
    }
    
}

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

class TitleLabel: UILabel, Updatable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        numberOfLines = 0
        
        font = UIFont.preferredFont(forTextStyle: .title1)
        
    }
    
    public func updateValue(_ value: Any?) {
        
        let post = value as? Post
        
        text = post?.title
        
    }
    
}

class BodyLabel: UILabel, Updatable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        numberOfLines = 0
        
        font = UIFont.preferredFont(forTextStyle: .body)
        
        textColor = .darkGray
        
    }
    
    public func updateValue(_ value: Any?) {
        
        let post = value as? Post
        
        text = post?.body
        
    }
    
}

enum PostListElement: String {
    
    case title
    
    case body
    
}

//struct PostListConfiguration: TemplateConfiguration {
//
//    typealias Element = PostListElement
//
//    func preferredViewName(for element: Element) -> String? { return nil }
//
//}

//typealias PostListTemplate = ConfigurableTemplate<PostListConfiguration>

struct Comment {
    
    let username: String
    
    let text: String
    
}

struct FeedStorage: Storage {
    
    enum Element {

        case comment(Comment)

    }
    
    typealias Storage = MemoryCache<Int, Any>
    
    var _storage = Storage()

    var keyDiff: KeyDiff { return _storage.keyDiff }

    var maxKey: Int? { return _storage.maxKey }
    
    func value(forKey key: Int) -> Any? { return _storage.value(forKey: key) }
    
    var values: AnyCollection<Any> { return _storage.values }
    
}

struct CommentItem: SectionItem {

    enum Element {

        case username

        case text

    }
    
    var storage: Comment
    
    var elements: [Element]

    var numberOfElements: Int { return elements.count }

    func view(at index: Int) -> View {
        
        let element = elements[index]

        // TODO: All elements share the same storage...
        let comment = storage.values.first

        switch element {

        case .username:
            
            let label = TitleLabel()

            label.text = storage.username

            return label

        case .text:
            
            let label = BodyLabel()

            label.text = storage.text

            return label

        }

    }

}

struct FeedCollection: SectionCollection {

    enum Item: SectionItem {

        typealias Element = Any

        case comment(CommentItem)

        var storage: Any {

            switch self {

            case let .comment(elements): return elements.storage

            }

        }

        var numberOfElements: Int {

            switch self {

            case let .comment(elements):
                
                return elements.numberOfElements

            }

        }

        func view(at index: Int) -> View {

            switch self {

            case let .comment(elements): return elements.view(at: index)

            }

        }

    }
    
    var _storage = MemoryCache<Int, Item>()

    var storage: AnyStorage<Int, Item> { return AnyStorage(_storage) }

    var numberOfItems: Int { return items.count }

    func item(at index: Int) -> Item { return items[index] }

}

class FeedListViewController: TableViewController<FeedCollection> { }

let viewController = FeedListViewController()

viewController.reducer = { storage in

    let items: [FeedCollection.Item] = storage.values.map { value in
        
        let element = value as! FeedStorage.Element

        switch element {

        case let .comment(comment):

            var item = CommentItem()
            
            item.elements = [
                .username,
                .text
            ]
            
            item._cache.setValues(
                [ comment ]
            )
            
            return .comment(item)

        }

    }

    return FeedCollection(items: items)
    
}

var storage = FeedStorage()

storage._storage.setValues(
    [
        FeedStorage.Element.comment(
            Comment(
                username: "Roy",
                text: "Hi"
            )
        )
    ]
)

viewController.storage = AnyStorage(storage)

PlaygroundPage.current.liveView = viewController

//let template: PostListTemplate = [
//    .title,
//    .body
//]
//
//viewController.template = template
//
//viewController.template?.registerView(
//    TitleLabel.self,
//    for: .title
//)
//
//viewController.template?.registerView(
//    BodyLabel.self,
//    for: .body
//)
//
//let manager = APIManager(
//    resource: PostResource(client: URLSession.shared)
//)
//
//viewController.storage = AnyStorage(manager)
//
//manager.load()

print("End")

PlaygroundPage.current.needsIndefiniteExecution = true
