import TinyKit
import TinyCore
import PlaygroundSupport

enum StorageError: Error {
    
    case valueNotFound(key: String)
    
}

class StorageOperation: Operation {
    
    enum OperationError: Error {
        
        case cancelled
        
    }
    
    let key: String
    
    let storage: NewMemoryCache<String, String>
    
    private(set) var result: Result<String>?
    
    private var _isExecuting = false
    
    override var isExecuting: Bool { return _isExecuting }
    
    override var isFinished: Bool { return result != nil }
    
    override var isAsynchronous: Bool { return true }
    
    init(
        key: String,
        storage: NewMemoryCache<String, String>
    ) {
        
        self.key = key
        
        self.storage = storage
        
    }
    
    override func start() { main() }
    
    override func main() {
        
        if isCancelled {

            result = .failure(OperationError.cancelled)

            return

        }
        
        _isExecuting = true
        
        storage.value(forKey: key) { result in
            
            self._isExecuting = false
            
            if self.isCancelled {
                
                self.result = .failure(OperationError.cancelled)
                
                return
                
            }
            
            self.result = result
            
        }
        
    }
    
}

class ConfigurableStorage {
    
    var storages: [NewMemoryCache<String, String>] = []
    
    init(storages: [NewMemoryCache<String, String>]) { self.storages = storages }
    
    private lazy var queue: OperationQueue = {
        
        let queue = OperationQueue()
        
        queue.maxConcurrentOperationCount = 1
        
        return queue
        
    }()
    
    func value(
        forKey key: String,
        completion: @escaping (Result<String>) -> Void
    ) {
        
        let operations: [StorageOperation] = storages.map { storage in
            
            let operation = StorageOperation(
                key: key,
                storage: storage
            )
            
            operation.completionBlock = {
                
                switch operation.result {
                    
                case let .success(value)?:
                    
                    self.queue.cancelAllOperations()
                    
                    completion(
                        .success(value)
                    )
                    
                default: break
                    
                }
                
            }
            
            return operation
            
        }
        
        queue.addOperations(
            operations,
            waitUntilFinished: false
        )
        
    }
    
}

let storage1: NewMemoryCache = [
    "Hello": "World1"
]

let storage2: NewMemoryCache = [
    "Hello": "World2",
    "Hi": "Roy"
]

let s = ConfigurableStorage(
    storages: [ storage1, storage2 ]
)

s.value(forKey: "Hello") { result in
    
    print(result)
    
}

PlaygroundPage.current.needsIndefiniteExecution = true

print("End")
