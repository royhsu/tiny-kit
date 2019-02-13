import TinyKit
import PlaygroundSupport

struct Message {
    
    let id = UUID()
    
    let text: String
    
}

extension Message: CursorRepresentable {
    
    var cursor: UUID { return id }
    
}

struct MessasgeService {
    
    let messages: [Message]
    
}

extension MessasgeService: PaginationService {
    
    @discardableResult
    func fetch(
        with request: FetchRequest<Message.Cursor>,
        completion: @escaping (Result<Page<Message, Message.Cursor> >) -> Void
    )
    throws -> ServiceTask {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            completion(
                .success(
                    Page(elements: self.messages)
                )
            )
            
        }
        
        return Task()
        
    }
    
    struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}

final class MessageTableViewController: UITableViewController {
    
    var paginationController: PaginationController<Message, Message.Cursor>? {
        
        didSet {
            
            paginationController?.elementStatesDidChange = { [weak self] controller in
                
                guard
                    let self = self,
                    self.isViewLoaded
                else { return }
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
    private var elementStates: [PaginationController<Message, Message.Cursor>.ElementState] { return paginationController?.elementStates ?? [] }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return elementStates.count }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return 1 }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )
    
        let state = elementStates[indexPath.section]
        
        switch state {

        case .inactive, .fetching: cell.textLabel?.text = "Loading..."

        case let .fetched(message): cell.textLabel?.text = message.text

        case .error: cell.textLabel?.text = "Error"

        }
        
        return cell
        
    }
    
}

let controller = MessageTableViewController()

let paginationController = PaginationController(
    fetchService: MessasgeService(
        messages: [
            Message(text: "A"),
            Message(text: "B"),
            Message(text: "C"),
            Message(text: "D"),
            Message(text: "E")
        ]
    )
)

controller.paginationController = paginationController

paginationController.performFetch()

PlaygroundPage.current.liveView = controller

print("End")
