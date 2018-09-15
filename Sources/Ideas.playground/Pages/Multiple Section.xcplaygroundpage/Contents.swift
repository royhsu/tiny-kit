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

protocol Template {
    
    associatedtype Section = ViewCollectionSection
    
    associatedtype Value
    
    func section(for value: Value) -> Section
    
}

protocol ViewCollection: ViewController {
    
    associatedtype Section = ViewCollectionSection
    
    var numberOfSection: Int { get }
    
    func section(at index: Int) -> Section
    
}

protocol Storage {
    
    associatedtype Value
    
    var count: Int { get }
    
    func value(at index: Int) -> Value
    
}

struct AnyStorage<Value>: Storage {
    
    private let _countProvider: () -> Int
    
    private let _valueProvider: (_ index: Int) -> Value
    
    init<S>(_ storage: S) where S: Storage, S.Value == Value {
        
        self._countProvider = { storage.count }
        
        self._valueProvider = storage.value
        
    }
    
    var count: Int { return _countProvider() }
    
    func value(at index: Int) -> Value { return _valueProvider(index) }
    
}

struct Post { }

class CollectionViewController<T>: ViewCollection where T: Template {
    
    typealias Value = T.Value
    
    typealias Section = T.Section
    
    var template: T
    
    var storage: AnyStorage<Value>
    
    var view: View
    
    init<S>(
        template: T,
        storage: S,
        view: View
    )
    where S: Storage, S.Value == Value {
            
        self.template = template
        
        self.storage = AnyStorage(storage)
        
        self.view = view
            
    }
    
    var numberOfSection: Int { return storage.count }
    
    func section(at index: Int) -> Section {
        
        let value = storage(at: index)
        
        return template.section(for: value)
        
    }
    
    func storage(at index: Int) -> Value { return storage.value(at: index) }
    
}
