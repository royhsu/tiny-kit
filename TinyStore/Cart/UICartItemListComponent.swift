//
//  UICartItemListComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemListComponent

public final class UICartItemListComponent: Component {
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() { listComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UICartItemListComponent {
    
    @discardableResult
    public final func setItems(
        _ items: [UICartItem]
    )
    -> UICartItemListComponent {
            
        let components: [Component] = items.map { item in
            
            let component = UICartItemComponent()
            
            component
                .setItem(item)
                .setDidChangeSelection { isSelected in
                    
                    
                    
                }
            
            return component
            
        }
        
        listComponent.itemComponents = AnyCollection(components)
        
        return self
            
    }
    
}
