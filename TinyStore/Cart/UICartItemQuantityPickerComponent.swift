//
//  UICartItemQuantityPickerComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemQuantityPickerComponent

public final class UICartItemQuantityPickerComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemQuantityPickerView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemQuantityPickerView.self,
                from: bundle
            )!
        )
        
        self.setItem(
            UICartItemQuantityPickerItem()
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

public extension UICartItemQuantityPickerComponent {
    
    @discardableResult
    public final func setItem(_ item: UICartItemQuantityPickerItem) -> UICartItemQuantityPickerComponent {
        
        let pickerView = itemComponent.itemView
        
        if let increaseIconImage = item.increaseIconImage {
            
            pickerView.increaseIconImageView.image = increaseIconImage
            
            pickerView.increaseIconImageView.backgroundColor = nil
            
        }
        else {
            
            pickerView.increaseIconImageView.image = nil
            
            pickerView.increaseIconImageView.backgroundColor = .lightGray
            
        }
        
        pickerView.increaseIconImageView.backgroundColor = item.increaseBackgroundColor
        
        pickerView.increaseIconImageView.tintColor = item.increaseTintColor
        
        if let decreaseIconImage = item.decreaseIconImage {
            
            pickerView.decreaseIconImageView.image = decreaseIconImage
            
            pickerView.decreaseIconImageView.backgroundColor = nil
            
        }
        else {
            
            pickerView.decreaseIconImageView.image = nil
            
            pickerView.decreaseIconImageView.backgroundColor = .lightGray
            
        }
        
        pickerView.decreaseIconImageView.backgroundColor = item.decreaseBackgroundColor
        
        pickerView.decreaseIconImageView.tintColor = item.decreaseTintColor
        
        pickerView.numberTextField.text = "\(item.quantity)"
        
        return self
        
    }
    
}
