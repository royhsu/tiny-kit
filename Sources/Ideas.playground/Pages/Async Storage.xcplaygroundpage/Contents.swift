import TinyKit
import TinyCore
import PlaygroundSupport

enum StorageError: Error {
    
    case valueNotFound(key: String)
    
}

struct ConfigurableStorage {
    
    var storages: [NewMemoryCache<String, String>] = []
    
    func value(
        forKey key: String,
        completion: @escaping (Result<String>) -> Void
    ) {
        
        let storages = self.storages
        
        DispatchQueue.global().async {
            
            for index in 0..<storages.count {
                
                let storage = storages[index]
                
                if let value = storage[key] {
                    
                    completion(
                        .success(value)
                    )
                    
                    return
                    
                }
                
            }
            
            completion(
                .failure(
                    StorageError.valueNotFound(key: key)
                )
            )
            
        }
        
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
