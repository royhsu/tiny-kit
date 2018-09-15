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

struct PostListConfiguration: TemplateConfiguration {
    
    typealias Element = PostListElement
    
    func preferredViewName(for element: Element) -> String? { return nil }
    
}

typealias PostListTemplate = ConfigurableTemplate<PostListConfiguration>

struct Comment { }

struct FeedStorage {
    
    enum Value {
        
        case comment(Comment)
        
    }
    
    var values: [Value]
    
}

struct CommentItem: SectionItem {
    
    enum Element {
        
        case username
        
        case text
        
    }
    
    var elements: [Element] = []
    
    var numberOfElements: Int { return elements.count }
    
    func element(at index: Int) -> Element { return elements[index] }
    
}

struct FeedSection: Section {

    enum Item: SectionItem {
        
        case comment(CommentItem)
        
        var numberOfElements: Int {
            
            switch self {
                
            case let .comment(elements): return elements.numberOfElements
                
            }
            
        }
        
        // Important: Any does the trick.
        func element(at index: Int) -> Any {
            
            switch self {
             
            case let .comment(elements): return elements.element(at: index)
                
            }
            
        }

    }

    var items: [Item] = []

    var numberOfItems: Int { return items.count }

    func item(at index: Int) -> Item { return items[index] }

}

//let a = FeedSection(
//    items: [
//        .comment(
//            CommentItem(
//                elements: [
//                    .username,
//                    .text
//                ]
//            )
//        )
//    ]
//)

//struct FeedSection: Section {
//
//    var items: [FeedItem] = []
//
//    var numberOfItems: Int { return items.count }
//
//    func item(at index: Int) -> FeedItem { return items[index] }
//
//}

protocol SectionReducer {
 
    associatedtype Storage
    
    associatedtype S: Section
    
    func reduce(storage: Storage) -> S
    
}

struct FeedReducer: SectionReducer {

    func reduce(storage: FeedStorage) -> FeedSection {

        let items: [FeedSection.Item] = storage.values.map { value in

            switch value {

            case .comment:

                let item = CommentItem(
                    elements: [
                        .username,
                        .text
                    ]
                )

                return .comment(item)

            }

        }

        return FeedSection(items: items)

    }

}

protocol CollectionViewController {
    
    associatedtype Reducer: SectionReducer
    
}

protocol TableView {
    
    
    
}

// TODO: Should use a type erasure for reducer.
class Table2ViewController<R>: UIViewController
where R: SectionReducer {

    typealias Storage = R.Storage

    typealias Section = R.S

    private var section: Section?

    private let dataSource = UITableViewDataSourceController()

    var storage: Storage? {

        didSet {

            update()

        }

    }

    private func update() {
     
        DispatchQueue.main.async { [weak self] in
            
            guard
                let self = self,
                let storage = self.storage,
                let reducer = self.reducer
            else { return }
            
            self.section = reducer.reduce(storage: storage)
            
            self.tableView.reloadData()
            
        }
        
    }
    
    var reducer: R? {
        
        didSet {
            
            update()
            
        }
        
    }

    private(set) lazy var tableView = UITableView()
    
    init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }

    override func loadView() { view = tableView }

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.separatorStyle = .none

        tableView.dataSource = dataSource

        dataSource.setNumberOfSections { [weak self] _ in

            return self?.section?.numberOfItems ?? 0

        }

        dataSource.setNumberOfRows { [weak self] _, index in

            let item = self?.section?.item(at: index)

            return item?.numberOfElements ?? 0

        }

        dataSource.setCellForRow { [weak self] _, indexPath in

            guard
                let self = self,
                let section = self.section?.item(at: indexPath.section)
            else { return UITableViewCell() }

            let cell = UITableViewCell()

            let element = section.element(at: indexPath.row)
            print(element)
            cell.textLabel?.text = "\(indexPath)"

//            let view = element.view

            return cell

        }

    }

}

let table2ViewController = Table2ViewController<FeedReducer>()

table2ViewController.reducer = FeedReducer()

PlaygroundPage.current.liveView = table2ViewController

table2ViewController.storage = FeedStorage(
    values: [
        .comment(Comment())
    ]
)

//class PostListViewController: TableViewController<PostListTemplate, Post> { }
//
//let viewController = PostListViewController()
//
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
//PlaygroundPage.current.liveView = viewController
//
//manager.load()

print("End")

PlaygroundPage.current.needsIndefiniteExecution = true
