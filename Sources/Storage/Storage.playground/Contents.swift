import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

class TableViewController<S: Storage>: UIViewController where S.Key == Int {
    
    typealias Index = Int
    
    let tableView = UITableView()
    
    let dataSourceController = UITableViewDataSourceController()
    
    var storage: S? {
        
        didSet {
         
            guard
                let storage = storage
            else { return }
            
            let subscription = storage.keyDiff.subscribe { _ in
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
            }
                
            subscriptions = [ subscription ]
                
        }
            
    }
    
    private var subscriptions: [ObservableSubscription] = []

    override func loadView() { view = tableView }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }
            
            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { _, _ in
            
            return 1
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            let cell = UITableViewCell()
            
            let element = self?.storage?[indexPath.section]
            
            cell.textLabel?.text = "\(indexPath)"
            
            return cell
            
        }
        
    }
    
}

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

typealias Cache = MemoryCache<Int, String>

let viewController = TableViewController<Cache>()

let cache = Cache()

viewController.storage = cache

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

    cache.setKeyValuePairs(
        [
            0: "Hello",
            1: "World",
            7: "QQ"
        ]
    )

}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//
//    cache.setValues(
//        [ "A", "B" ]
//    )
//
//}

print("End")

PlaygroundPage.current.needsIndefiniteExecution = true
