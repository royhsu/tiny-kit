import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

protocol Storage {
    
    var count: Int { get }
    
    subscript(_ index: Int) -> String? { get }
    
    var indexDiff: IndexDiff { get }
    
}

class TableViewController: UIViewController {
    
    let tableView = UITableView()
    
    let dataSourceController = UITableViewDataSourceController()
    
    var storage: Storage?
    
    private var indexDiffSubscription: ObservableSubscription?

    override func loadView() { view = tableView }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            return self?.storage?.count ?? 0
            
        }
        
        dataSourceController.setNumberOfRows { [weak self] _, _ in
            
            return 1
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            let cell = UITableViewCell()
            
            let element = self?.storage?[indexPath.section]
            
            cell.textLabel?.text = element
            
            return cell
            
        }
        
        indexDiffSubscription = storage?.indexDiff.subscribe { event in
            
            guard
                let indcies = event.currentValue
            else { return }
            
            DispatchQueue.main.async {

                // Not the old indices handled yet.
//                self.tableView.beginUpdates()
//
//                self.tableView.reloadSections(
//                    IndexSet(indcies),
//                    with: .automatic
//                )
//
//                self.tableView.endUpdates()

                self.tableView.reloadData()

            }
            
        }
        
    }
    
}

class IndexDiff: ObservableProtocol {
    
    typealias Indices = [Int]
    
    private let _storage = Observable<Indices>()
    
    var value: Indices? {
        
        get { return _storage.value }
        
        set { _storage.value = newValue }
        
    }
    
    func setValue(
        _ value: Indices?,
        options: ObservableValueOptions?
    ) {
     
        _storage.setValue(
            value,
            options: options
        )
        
    }
    
    func subscribe(with subscriber: @escaping Subscriber) -> ObservableSubscription {
        
        return _storage.subscribe(with: subscriber)
        
    }
    
}

class Cache: Storage {
    
    typealias Index = Int
    
    let indexDiff = IndexDiff()
    
    private var _storage: [String?] = []
    
    var count: Int { return _storage.count }
    
    subscript(_ index: Index) -> String? {
        
        get { return _storage[index] }
     
        set {
            
            let currentLastIndex = _storage.count
            
            let newLastIndex = index + 1
            
            let unallocatedCount = newLastIndex - currentLastIndex
            
            if unallocatedCount > 0 {
            
                _storage.append(
                    contentsOf: Array(
                        repeating: nil,
                        count: unallocatedCount
                    )
                )
                
            }
            
            _storage[index] = newValue
            
            indexDiff.value = [ index ]
            
        }
        
    }
    
    func setValues(_ values: [String?]) {
        
        _storage = values
        
        indexDiff.value = values.indices.map { $0 }
        
    }
    
}

let viewController = TableViewController()

let cache = Cache()

viewController.storage = cache

PlaygroundPage.current.liveView = viewController

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    
    cache.setValues(
        [ "A", "B", "C", "D" ]
    )
    
}

print("End")

PlaygroundPage.current.needsIndefiniteExecution = true
