import TinyKit
import PlaygroundSupport

final class MessageTableViewController: UITableViewController {

    var prefetchController: PrefetchController<Message, MessageService.Cursor>? {

        didSet {

            prefetchController?.elementStatesDidChange = { [weak self] controller in

                guard
                    let self = self,
                    self.isViewLoaded
                else { return }

                print("new states", controller.elementStates)
                
                DispatchQueue.main.sync {

                    self.tableView.reloadData()

                }

            }

        }

    }

    private var elementStates: ElementStateArray<Message> {
        
        var states = prefetchController?.elementStates ?? []
        
        states.willGetElementState = nil
        
        return states
        
    }

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

controller.prefetchController = PrefetchController(
    fetchRequest: FetchRequest(
        fetchCursor: .middle,
        fetchLimit: 2
    ),
    fetchService: MessageService(
        result: .success(
            .init(
                firstPageMessages: [ Message(text: "a") ],
                middlePageMessages: [ Message(text: "b") ],
                lastPageMessages: [ Message(text: "c") ]
            )
        )
    )
)

controller.prefetchController?.performFetch()

PlaygroundPage.current.liveView = controller

print("End")
