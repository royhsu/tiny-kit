//
//  UIProductDescriptionComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescriptionComponent

import TinyUI

public final class UIProductDescriptionComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductDescriptionView>
    
    private final let actionButtonComponent: UIPrimaryButtonComponent
    
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
        
        self.actionButtonComponent = UIPrimaryButtonComponent()
        
        self.setDescription(
            UIProductDescription()
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let descriptionView = itemComponent.itemView
        
        descriptionView.actionContainerView.render(with: actionButtonComponent)
        
        actionButtonComponent.render()
        
        itemComponent.render()
        
    }
    
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
    
    @discardableResult
    public final func setActionButtonItem(_ item: UIPrimaryButtonItem) -> UIProductDescriptionComponent {
        
        actionButtonComponent.setItem(item)
        
        return self
        
    }
    
    public typealias DidTapHandler = () -> Void
    
    @discardableResult
    public final func setDidTap(_ handler: DidTapHandler?) -> UIProductDescriptionComponent {
        
        actionButtonComponent.onTap(handler: handler)
        
        return self
        
    }
    
}
