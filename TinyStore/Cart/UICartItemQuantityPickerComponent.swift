//
//  UICartItemQuantityPickerComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemQuantityPickerError

public enum UICartItemQuantityPickerError: Error {
    
    case invalidQuantity(
        string: String,
        validRange: Range<Int>
    )
    
}

// MARK: - UICartItemQuantityPickerComponent

public final class UICartItemQuantityPickerComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemQuantityPickerView>
    
    private final let quntityTextFieldBridge: UITextFieldBridge
    
    private final var currentItem: UICartItemQuantityPickerItem
    
    public typealias ErrorHandler = (Error) -> Void
    
    private final var errorHandler: ErrorHandler?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemQuantityPickerView.self,
                from: bundle
            )!
        )
        
        self.itemComponent = itemComponent
        
        self.quntityTextFieldBridge = UITextFieldBridge(textField: itemComponent.itemView.numberTextField)
        
        self.currentItem = UICartItemQuantityPickerItem()
        
        quntityTextFieldBridge.didEndEditing = { [unowned self] textField in
            
            let currentText = textField.text ?? ""
            
            guard
                let quantity = Int(currentText),
                quantity > 0,
                quantity < 100
            else  {
                
                self.currentItem.quantity = 1
                
                self.setItem(self.currentItem)
                
                let error: UICartItemQuantityPickerError = .invalidQuantity(
                    string: currentText,
                    validRange: 1..<100
                )
                
                self.errorHandler?(error)
                
                return
                
            }
            
            self.currentItem.quantity = quantity
            
            self.setItem(self.currentItem)
            
        }
        
        itemComponent.itemView.increaseButton.addTarget(
            self,
            action: #selector(increaseNumber),
            for: .touchUpInside
        )
        
        itemComponent.itemView.decreaseButton.addTarget(
            self,
            action: #selector(decreaseNumber),
            for: .touchUpInside
        )
        
        let toolBar = UIToolbar()
        
        toolBar.setItems(
            [
                UIBarButtonItem(
                    barButtonSystemItem: .flexibleSpace,
                    target: nil,
                    action: nil
                ),
                UIBarButtonItem(
                    barButtonSystemItem: .done,
                    target: self,
                    action: #selector(dismissKeyboard)
                )
            ],
            animated: false
        )
        
        toolBar.sizeToFit()
        
        itemComponent.itemView.numberTextField.inputAccessoryView = toolBar
        
        setItem(currentItem)
        
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
    
    // MARK: Action
    
    @objc
    public final func increaseNumber(_ sender: Any) {
        
        if currentItem.quantity >= 99 { return }
        
        currentItem.quantity += 1
        
        setItem(currentItem)
        
    }
    
    @objc
    public final func decreaseNumber(_ sender: Any) {
        
        if currentItem.quantity <= 0 { return }
        
        currentItem.quantity -= 1
        
        setItem(currentItem)
        
    }
    
    @objc
    public final func dismissKeyboard(_ sender: Any) { view.endEditing(true) }
    
}

public extension UICartItemQuantityPickerComponent {
    
    @discardableResult
    public final func setItem(_ item: UICartItemQuantityPickerItem) -> UICartItemQuantityPickerComponent {
        
        currentItem = item
        
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
    
    @discardableResult
    public final func onError(handler: ErrorHandler?) -> UICartItemQuantityPickerComponent {
        
        errorHandler = handler
        
        return self
        
    }
    
}
