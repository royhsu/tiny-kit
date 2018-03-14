//
//  UIProductDescriptionComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescriptionComponent

public final class UIProductDescriptionComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductDescriptionView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductDescriptionView.self,
                from: bundle
            )!
        )
        
        self.setDescription(
            UIProductDescription()
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() { itemComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

public extension UIProductDescriptionComponent {
    
    @discardableResult
    public final func setDescription(_ description: UIProductDescription) -> UIProductDescriptionComponent {
        
        let descriptionView = itemComponent.itemView
        
        descriptionView.titleLabel.text = description.title
        
        descriptionView.subtitleLabel.text = description.subtitle
        
        return self
        
    }
    
}
