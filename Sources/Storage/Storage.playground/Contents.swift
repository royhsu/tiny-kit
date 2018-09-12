import TinyCore
import TinyKit
import UIKit
import PlaygroundSupport

protocol Storage {
    
    var count: Int { get }
    
    subscript(_ index: Int) -> String? { get }
    
}

class TableViewController: UIViewController {
    
    let tableView = UITableView()
    
    let dataSourceController = UITableViewDataSourceController()
    
    var storage: Storage?

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
        
    }
    
}

class Cache: Storage {
    
    var strings = [ "A", "B" ]
    
    var count: Int { return strings.count }
    
    subscript(_ index: Int) -> String? { return strings[index] }
    
}

let viewController = TableViewController()

viewController.storage = Cache()

PlaygroundPage.current.liveView = viewController

print("End")
