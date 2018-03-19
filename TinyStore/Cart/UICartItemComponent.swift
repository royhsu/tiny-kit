//
//  UICartItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemComponent

import TinyUI

public final class UICartItemComponent: Component {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemView>
    
    private final let selectionCheckboxComponent: UICheckboxComponent
    
    private final var selectionSubscription: Subscription<Bool>?
    
    private final let quantityPickerComponent: UINumberPickerComponent
    
    private final var quantitySubscription: Subscription<Int>?
    
    public typealias DidChangeQuantityHandler = (_ qunatity: Int) -> Void
    
    private final var didChangeQuantityHandler: DidChangeQuantityHandler?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        let itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemView.self,
                from: bundle
            )!
        )
        
        self.itemComponent = itemComponent
        
        self.selectionCheckboxComponent = UICheckboxComponent()
        
//        let pickerTintColor = UIColor(
//            red: 0.35,
//            green: 0.56,
//            blue: 0.87,
//            alpha: 1.0
//        )
//        .modifiedWithAdditionalHue(
//            0.0,
//            saturation: -0.3,
//            brightness: 0.0
//        )
        
        self.quantityPickerComponent = UINumberPickerComponent(
            minimumValue: 1,
            maximumValue: 99
        )
            
        quantityPickerComponent.setDidFail { error in

            // TODO: error handling.
            print("\(error)")

        }
        
        quantitySubscription = quantityPickerComponent.input.subscribe { [unowned self] oldValue, newValue in
            
            self.didChangeQuantityHandler?(newValue)
            
//            print(
//                "old:",
//                oldValue,
//                "new:",
//                newValue
//            )
            
        }
        
        itemComponent.itemView.editButton.setTitle(
            NSLocalizedString(
                "Edit",
                comment: ""
            ),
            for: .normal
        )
        
        itemComponent.itemView.editButton.setTitleColor(
            .darkGray,
            for: .normal
        )
        
        itemComponent.itemView.deleteButton.setTitle(
            NSLocalizedString(
                "Delete",
                comment: ""
            ),
            for: .normal
        )
        
        itemComponent.itemView.deleteButton.setTitleColor(
            .darkGray,
            for: .normal
        )
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        let itemView = itemComponent.itemView
        
        selectionSubscription = selectionCheckboxComponent.input.subscribe { _, isSelected in
            
            itemView.contentContainer.alpha = (isSelected ? 1.0 : 0.5)
            
        }
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let itemView = itemComponent.itemView
        
        itemView.selectionContainerView.render(with: selectionCheckboxComponent)
        
        selectionCheckboxComponent.render()
        
        itemView.quantityPickerContainerView.render(with: quantityPickerComponent)
        
        quantityPickerComponent.render()
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Action
    
    public typealias DidChangeSelectionHandler = (_ isSelected: Bool) -> Void
    
    private final var didChangeSelectionHandler: DidChangeSelectionHandler?
    
}

public extension UICartItemComponent {
    
    @discardableResult
    public final func setItem(_ item: UICartItem) -> UICartItemComponent {
        
        let itemView = itemComponent.itemView
        
        if let previewImage = item.previewImage {
            
            itemView.previewImageView.image = previewImage
            
            itemView.previewImageView.backgroundColor = nil
            
        }
        else {
            
            itemView.previewImageView.image = nil
            
            itemView.previewImageView.backgroundColor = .lightGray
            
        }
        
        itemView.titleLabel.text = item.title
        
        if let price = item.price {
            
            itemView.priceLabel.text = "$ \(price)"
            
        }
        else { itemView.priceLabel.text = "$" }
        
        return self
        
    }
    
    @discardableResult
    public final func setDidChangeSelection(_ handler: DidChangeSelectionHandler?) -> UICartItemComponent {
        
        didChangeSelectionHandler = handler
        
        return self
        
    }
    
    @discardableResult
    public final func setQuantity(_ quantity: Int) -> UICartItemComponent {
        
        quantityPickerComponent.input.value = quantity
        
        return self
        
    }
    
    @discardableResult
    public final func setDidChagneQuantity(_ handler: DidChangeQuantityHandler? = nil) -> UICartItemComponent {
        
        didChangeQuantityHandler = handler
        
        return self
        
    }
    
}
