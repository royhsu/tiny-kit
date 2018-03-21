//
//  UIProductDescriptionComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescriptionComponent

import TinyUI

internal final class UIProductDescriptionComponent: Component, Stylable {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductDescriptionView>
    
    private final let actionButtonComponent: UIPrimaryButtonComponent
    
    internal init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current,
        actionButtonComponent: UIPrimaryButtonComponent
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductDescriptionView.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        self.actionButtonComponent = actionButtonComponent
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let descriptionView = itemComponent.itemView
        
        descriptionView.applyTheme(theme)
        
    }
    
    // MARK: Component
    
    internal final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    internal final func render() {
        
        let descriptionView = itemComponent.itemView
        
        descriptionView.actionContainerView.render(with: actionButtonComponent)
        
        descriptionView.applyTheme(theme)
        
        actionButtonComponent.render()
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    internal final var view: View { return itemComponent.view }
    
    internal final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    internal final var theme: Theme
    
}

internal extension UIProductDescriptionComponent {
    
    @discardableResult
    internal final func setTitle(_ title: String?) -> UIProductDescriptionComponent {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self
        
    }
    
    @discardableResult
    internal final func setSubtitle(_ subtitle: String?) -> UIProductDescriptionComponent {
        
        itemComponent.itemView.subtitleLabel.text = subtitle
        
        return self
        
    }
    
}
