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
    
    private final var quantitySubscription: Subscription<Int>?
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current
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
        
        self.selectionComponent = UICheckboxComponent()
        
        self.quantityComponent = UINumberPickerComponent()

        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        let itemView = itemComponent.itemView
        
        selectionSubscription = selectionComponent.input.subscribe { _, isSelected in
            
            self.didChangeSelectionHandler?(isSelected)
            
            itemView.contentContainer.alpha = (isSelected ? 1.0 : 0.5)
            
        }
        
        quantitySubscription = quantityComponent.input.subscribe { [unowned self] oldValue, newValue in
            
            self.didChangeQuantityHandler?(newValue)
            
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
    
    // MARK: Action
    
    public typealias DidChangeSelectionHandler = (_ isSelected: Bool) -> Void
    
    private final var didChangeSelectionHandler: DidChangeSelectionHandler?
    
    public typealias DidChangeQuantityHandler = (_ qunatity: Int) -> Void
    
    private final var didChangeQuantityHandler: DidChangeQuantityHandler?
    
}

public extension UICartItemComponent {
    
    @discardableResult
    public final func setQuantity(_ quantity: Int) -> UICartItemComponent {
        
        quantityComponent.input.value = quantity
        
        return self
        
    }
    
    @discardableResult
    public final func setDidChangeSelection(_ handler: DidChangeSelectionHandler?) -> UICartItemComponent {
        
        didChangeSelectionHandler = handler
        
        return self
        
    }
    
    @discardableResult
    public final func setDidChagneQuantity(_ handler: DidChangeQuantityHandler? = nil) -> UICartItemComponent {
        
        didChangeQuantityHandler = handler
        
        return self
        
    }
    
    public typealias DidFailHandler = (Error) -> Void
    
    @discardableResult
    public final func setDidFail(_ handler: DidFailHandler?) -> UICartItemComponent {
        
        quantityComponent.setDidFail(handler)
        
        return self
        
    }
    
}
