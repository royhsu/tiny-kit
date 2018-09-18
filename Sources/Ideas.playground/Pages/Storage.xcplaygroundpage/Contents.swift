import TinyCore
import TinyKit
import PlaygroundSupport

struct Iterator: IteratorProtocol {
    
    let storages: [ NewMemoryCache<String, String> ]
    
    let key: String
    
    let completion: (_ result: String?) -> Void
    
    init(
        storages: [ NewMemoryCache<String, String> ],
        key: String,
        completion: @escaping (_ result: String?) -> Void
    ) {
        
        self.storages = storages
        
        self.key = key
        
        self.completion = completion
        
    }
    
    private var fetchingIndex = 0
    
    mutating func next() -> NewMemoryCache<String, String>? {
        
        if storages.isEmpty { completion(nil); return nil }
        
        let storage = storages[fetchingIndex]
        
        if let value = storage[key] {
            
            completion(value)

            return nil
            
        }
        
        fetchingIndex += 1
        
        if fetchingIndex >= storages.count { completion(nil); return nil }
        
        return storages[fetchingIndex]
        
    }
    
}

struct ConfigurableStorage: Sequence {
    
    var key: String
    
    func makeIterator() -> Iterator {
        
        let storage1: NewMemoryCache = [
            "Hello": "World"
        ]
        
        let storage2: NewMemoryCache = [
            "Hi": "Roy"
        ]
        
        return Iterator(
            storages: [ storage1, storage2 ],
            key: key,
            completion: { result in
                
                print("Found data:", result)
                
            }
        )
        
    }
    
}

let storage = ConfigurableStorage(key: "Hi")

for s in storage {
    
    print(s)
    
}

PlaygroundPage.current.needsIndefiniteExecution = true

print("End")
