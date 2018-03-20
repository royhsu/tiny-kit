//
//  UILandingComponent.swift
//  TinyLanding
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingComponent

public final class UILandingComponent: Component {
    
    /// The base component.
    private final var listComponent: UIListComponent
    
    private final let logoComponent: UILandingLogoComponent
    
    private final var buttonComponents: [UIPrimaryButtonComponent] = []
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.logoComponent = UILandingLogoComponent()
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        switch contentMode {
            
        case .automatic:
            
            let width = listComponent.view.bounds.width
            
            logoComponent.contentMode = .size(
                width: width,
                height: width
            )
            
        case .size(let width, _):
            
            logoComponent.contentMode = .size(
                width: width,
                height: width
            )
            
        }
        
        listComponent.headerComponent = logoComponent
        
        listComponent.itemComponents = AnyCollection(buttonComponents)
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UILandingComponent {
    
    @discardableResult
    public final func setLogo(_ logo: UILandingLogo) -> UILandingComponent {
        
        logoComponent.setLogo(logo)
        
        return self
        
    }
    
    @discardableResult
    public final func addButton(
        with item: UIPrimaryButtonItem,
        action handler: @escaping () -> Void
    ) 
    -> UILandingComponent {
        
        let component = UIPrimaryButtonComponent()
            .setTitle(item.title)
            .setAction(handler)
            
        buttonComponents.append(component)
        
        return self
        
    }
    
}
