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
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemView>
    
    private final let checkboxComponent: UICheckboxComponent
    
    private final let quantityPickerComponent: UINumberPickerComponent
    
    private final var quantitySubscription: Subscription<Int>?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
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
        
        self.checkboxComponent = UICheckboxComponent()
            .setChecked(true)
            .onToggleCheckbox { isSelected in
                
                let itemView = itemComponent.itemView
                
                itemView.contentContainer.alpha = (isSelected ? 1.0 : 0.5)
                
            }
        
        let pickerTintColor = UIColor(
            red: 0.35,
            green: 0.56,
            blue: 0.87,
            alpha: 1.0
        )
        .modifiedWithAdditionalHue(
            0.0,
            saturation: -0.3,
            brightness: 0.0
        )
        
        self.quantityPickerComponent = UINumberPickerComponent(
            minimumNumber: 1,
            maximumNumber: 99
        )
        .setItem(
            UINumberPickerItem(
                increaseIconImage: #imageLiteral(resourceName: "icon-plus").withRenderingMode(.alwaysTemplate),
                increaseBackgroundColor: pickerTintColor,
                increaseTintColor: .white,
                decreaseIconImage: #imageLiteral(resourceName: "icon-minus").withRenderingMode(.alwaysTemplate),
                decreaseBackgroundColor: pickerTintColor,
                decreaseTintColor: .white
            )
        )
        .onDidFail { error in

            // TODO: error handling.
            print("\(error)")

        }
        
        quantitySubscription = quantityPickerComponent.input.subscribe { oldValue, newValue in
            
            print(
                "old:",
                oldValue,
                "new:",
                newValue
            )
            
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
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let itemView = itemComponent.itemView
        
        itemView.selectionContainerView.render(with: checkboxComponent)
        
        checkboxComponent.render()
        
        itemView.quantityPickerContainerView.render(with: quantityPickerComponent)
        
        quantityPickerComponent.render()
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
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
    
    public typealias ToggleSelectionHandler = (_ isSelected: Bool) -> Void
    
    @discardableResult
    public final func onToggleSelection(handler: @escaping ToggleSelectionHandler) -> UICartItemComponent {
        
        let itemView = itemComponent.itemView
        
        checkboxComponent.onToggleCheckbox { isSelected in
            
            itemView.contentContainer.alpha = (isSelected ? 1.0 : 0.5)
            
            handler(isSelected)
            
        }
        
        return self
        
    }
    
    @discardableResult
    public final func setQuantity(_ quantity: Int) -> UICartItemComponent {
        
        quantityPickerComponent.input.value = quantity
        
        return self
        
    }
    
}
