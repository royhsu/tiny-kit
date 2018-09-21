import TinyCore
import TinyKit
import PlaygroundSupport

protocol Prefetchable {
    
    func setNumberOfPrefetchingSections(
        provider: @escaping (View) -> Int
    )
    
    func setNumberOfPrefetchingItems(
        provider: @escaping (View, _ section: Int) -> Int
    )
    
    func setViewForPrefetchingItem(
        provider: @escaping (View, IndexPath) -> View
    )
    
}

PlaygroundPage.current.needsIndefiniteExecution = true

print("End")
