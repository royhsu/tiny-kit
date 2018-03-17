//
//  UICartBarComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartBarComponent

import TinyUI

public final class UICartBarComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartBar>
    
    private final let actionButtonComponent: UIPrimaryButtonComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartBar.self,
                from: bundle
            )!
        )
        
        self.actionButtonComponent = UIPrimaryButtonComponent()
        
        self.setItem(
            UICartBarItem()
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let barView = itemComponent.itemView
        
        barView.actionContainerView.render(with: actionButtonComponent)
        
        actionButtonComponent.render()
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

public extension UICartBarComponent {
    
    @discardableResult
    public final func setItem(_ item: UICartBarItem) -> UICartBarComponent {
        
        let barView = itemComponent.itemView
        
        barView.amountLabel.text = "$ \(item.amount)"
        
        return self
        
    }
    
    @discardableResult
    public final func setActionButtonItem(_ item: UIPrimaryButtonItem) -> UICartBarComponent {
        
        actionButtonComponent.setItem(item)
        
        return self
        
    }
    
}