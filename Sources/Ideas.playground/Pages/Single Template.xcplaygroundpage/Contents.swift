protocol View {
    
    init()
    
}

protocol CollectionView: View { }

class BridgedCollectionView: CollectionView {
    
    required init() { }
    
}

protocol ViewRepresentable {
    
    var view: View { get }
    
}

protocol ViewController: ViewRepresentable {
    
    associatedtype Storage
    
    var storage: Storage { get set }
    
}

enum ViewContainer {
    
    case view(View)
    
    case viewController(View)
    
}

extension ViewContainer: ViewRepresentable {
    
    var view: View {
        
        switch self {
            
        case let .view(view): return view
            
        case let .viewController(view): return view
            
        }
        
    }
    
}

protocol ViewCollectionSection: ViewController {
    
    associatedtype Item = ViewController
    
    var numberOfItems: Int { get }
    
    func item(at index: Int) -> Item
    
}

protocol ViewCollection: ViewController {
    
    associatedtype Section = ViewCollectionSection
    
    var numberOfSection: Int { get }
    
    func section(at index: Int) -> Section
    
}

struct Post { }

protocol Template {
    
    associatedtype Element
    
    var elements: AnyCollection<Element> { get }
    
}

class CollectionViewController<T>: ViewCollection where T: Template {
    
    struct Section: ViewCollectionSection {
        
        typealias Item = T.Element
        
        var template: T
        
        var storage: Post
        
        var view: View
        
        var numberOfItems: Int { return template.elements.count }
        
        func item(at index: Int) -> Item { return template.elements[ AnyIndex(index) ] }
        
    }
    
    var template: T
    
    var storage: [Post]
    
    var view: View
    
    init(
        template: T,
        storage: [Post],
        view: View
    ) {
        
        self.template = template
        
        self.storage = storage
        
        self.view = view
        
    }
    
    var numberOfSection: Int { return storage.count }
    
    func section(at index: Int) -> Section {
        
        return Section(
            template: template,
            storage: storage[index],
            view: BridgedCollectionView()
        )
        
    }
    
    func storage(at index: Int) -> Post { return storage[index] }
    
}

struct PostTemplate: Template {
    
    enum Element {
        
        case title
        
        case body
        
    }
    
    var elements: AnyCollection<Element>
    
    init(elements: [Element]) { self.elements = AnyCollection(elements) }
    
}

let controller = CollectionViewController(
    template: PostTemplate(
        elements: [
            .title,
            .body
        ]
    ),
    storage: [ Post() ],
    view: BridgedCollectionView()
)

print("End")
