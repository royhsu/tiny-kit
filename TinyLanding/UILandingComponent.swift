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
    
    private final let logoComponent: UIItemComponent<UILandingLogoView>
    
    private final var buttonComponents: [UIPrimaryButtonComponent] = []
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.logoComponent = UIItemComponent(
            itemView: UIView.load(
                UILandingLogoView.self,
                from: bundle
            )!
        )
        
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
    public final func setLogo(_ logo: UILandingLogo? = nil) -> UILandingComponent {
        
        let logoView = logoComponent.itemView
        
        logoView.logoImageView.image = logo?.logoImage
        
        logoView.backgroundImageView.image = logo?.backgroundImage
        
        logoView.backgroundColor = logo?.backgroundColor
        
        return self
        
    }
    
    @discardableResult
    public final func addButton(
        with item: UIPrimaryButtonItem,
        action handler: @escaping () -> Void
    ) 
    -> UILandingComponent {
        
        let component = UIPrimaryButtonComponent()
            .setButtonItem(item)
            .onTap(handler: handler)
        
        buttonComponents.append(component)
        
        return self
        
    }
    
}
