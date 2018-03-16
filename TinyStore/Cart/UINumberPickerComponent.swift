//
//  UINumberPickerComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerComponent

public final class UINumberPickerComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UINumberPickerView>
    
    private final let numberTextFieldBridge: UITextFieldBridge
    
    private final var currentItem: UINumberPickerItem
    
    public typealias DidChagneNumberHandler = (_ number: Int) -> Void
    
    public typealias DidFailHandler = (_ error: Error) -> Void
    
    private final var didFailHandler: DidFailHandler?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UINumberPickerView.self,
                from: bundle
            )!
        )
        
        self.itemComponent = itemComponent
        
        self.numberTextFieldBridge = UITextFieldBridge(textField: itemComponent.itemView.numberTextField)
        
        self.currentItem = UINumberPickerItem()
        
        numberTextFieldBridge.didEndEditing = { [unowned self] textField in
            
            let currentText = textField.text ?? ""
            
            let min = self.currentItem.minimumNumber
            
            let max = self.currentItem.maximumNumber
            
            guard
                let quantity = Int(currentText),
                quantity >= min,
                quantity <= max
            else  {
                
                self.currentItem.number = 1
                
                self.setItem(self.currentItem)
                
                let error: UINumberPickerError = .invalidNumber(
                    string: currentText,
                    validMinimum: min,
                    validMaximum: max
                )
                
                self.didFailHandler?(error)
                
                return
                
            }
            
            self.currentItem.number = quantity
            
            self.setItem(self.currentItem)
            
        }
        
        setUpIncreaseButton(itemComponent.itemView.increaseButton)
        
        setUpDecreaseButton(itemComponent.itemView.decreaseButton)
        
        setUpNumberTextField(itemComponent.itemView.numberTextField)
        
        setItem(currentItem)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpIncreaseButton(_ button: UIButton) {
        
        button.addTarget(
            self,
            action: #selector(increaseNumber),
            for: .touchUpInside
        )
        
    }
    
    fileprivate final func setUpDecreaseButton(_ button: UIButton) {
        
        button.addTarget(
            self,
            action: #selector(decreaseNumber),
            for: .touchUpInside
        )
        
    }
    
    fileprivate final func setUpNumberTextField(_ textField: UITextField) {
        
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
        
        textField.inputAccessoryView = toolBar
        
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
        
        guard
            currentItem.number < currentItem.maximumNumber
        else { return }
        
        currentItem.number += 1
        
        setItem(currentItem)
        
    }
    
    @objc
    public final func decreaseNumber(_ sender: Any) {
        
        guard
            currentItem.number > currentItem.minimumNumber
        else { return }
        
        currentItem.number -= 1
        
        setItem(currentItem)
        
    }
    
    @objc
    public final func dismissKeyboard(_ sender: Any) { view.endEditing(true) }
    
}

public extension UINumberPickerComponent {
    
    @discardableResult
    public final func setItem(_ item: UINumberPickerItem) -> UINumberPickerComponent {
        
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
        
        pickerView.numberTextField.text = "\(item.number)"
        
        return self
        
    }
    
    @discardableResult
    public final func onDidChangeNumber(handler: DidChagneNumberHandler?) -> UINumberPickerComponent {

        currentItem.didChangeNumberHandler = handler
        
        return self
        
    }
    
    @discardableResult
    public final func onDidFail(handler: DidFailHandler?) -> UINumberPickerComponent {
        
        didFailHandler = handler
        
        return self
        
    }
    
}
