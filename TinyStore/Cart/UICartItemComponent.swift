//
//  UICartItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemComponent

import TinyUI

public final class UICartItemComponent: Component, Stylable {

    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemView>
    
    private final let selectionComponent: UICheckboxComponent
    
    private final var selectionSubscription: Subscription<Bool>?
    
    private final let quantityComponent: UINumberPickerComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current,
        selectionComponent: UICheckboxComponent,
        quantityComponent: UINumberPickerComponent
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemView.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        self.selectionComponent = selectionComponent
        
        self.quantityComponent = quantityComponent

        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        let itemView = itemComponent.itemView
        
        selectionSubscription = selectionComponent.input.subscribe { _, isSelected in
            
            itemView.contentContainer.alpha = (isSelected ? 1.0 : 0.5)
            
        }
        
        itemView.applyTheme(theme)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let itemView = itemComponent.itemView
        
        itemView.selectionContainerView.render(with: selectionComponent)
        
        selectionComponent.render()
        
        itemView.quantityPickerContainerView.render(with: quantityComponent)
        
        quantityComponent.render()
        
        itemView.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme

}
