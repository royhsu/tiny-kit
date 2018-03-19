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
        
        self.actionDescriptors = []

        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let itemView = itemComponent.itemView
        
        setUpContentView(
            itemView.contentContainerView,
            isSelected: selectionComponent.input.value
        )
        
        selectionSubscription = selectionComponent.input.subscribe { [unowned self] _, isSelected in
            
            self.setUpContentView(
                itemView.contentContainerView,
                isSelected: isSelected
            )
            
        }
        
        itemView.applyTheme(theme)
        
    }
    
    fileprivate func setUpContentView(
        _ view: UIView,
        isSelected: Bool
    ) { view.alpha = (isSelected ? 1.0 : 0.5) }
    
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
    
    private final var actionDescriptors: [UICartItemActionDescriptor]

}

public extension UICartItemComponent {
    
    @discardableResult
    public final func setPreviewImages(
        _ images: [UIImage]
    )
    -> UICartItemComponent {
        
        itemComponent.itemView.previewImageView.image = images.first
        
        return self
        
    }
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UICartItemComponent {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self
        
    }
    
    @discardableResult
    public final func setPrice(_ price: Double) -> UICartItemComponent {
        
        itemComponent.itemView.priceLabel.text = "$\(price)"
        
        return self
        
    }
    
    @discardableResult
    public final func setActionDescriptors(
        _ descriptors: [UICartItemActionDescriptor]
    )
    -> UICartItemComponent {
        
        actionDescriptors = descriptors
        
        for index in 0..<descriptors.count {
            
            let descriptor = descriptors[index]
            
            let titleLabel: UILabel?
            
            switch index {
            
            case 0: titleLabel = itemComponent.itemView.firstTitleLabel
             
            case 1: titleLabel = itemComponent.itemView.secondTitleLabel
                
            default: titleLabel = nil
                
            }
            
            titleLabel?.text = descriptor.title
            
        }
        
        return self
        
    }
    
}


// MARK: - UICartItemActionDescriptor

public struct UICartItemActionDescriptor {
    
    public typealias ActionHandler = () -> Void
    
    public let title: String
    
    public let handler: ActionHandler
    
    public init(
        title: String,
        handler: @escaping ActionHandler
    ) {
        
        self.title = title
        
        self.handler = handler
        
    }
    
}
