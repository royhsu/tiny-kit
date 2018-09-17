import TinyCore
import PlaygroundSupport

enum ButtonAction {
    
    case buttonClicked
    
}

let dispatcher = Observable<ButtonAction>()

let s = dispatcher.subscribe { event in
    
    switch event.currentValue {
        
    case .clicked?: print("Clicked.")
        
    case .none: print("None.")
        
    }
    
}

dispatcher.value = .clicked

PlaygroundPage.current.needsIndefiniteExecution = true

print("End")
