//
//  UINumberPickerComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerComponent

public final class UINumberPickerComponent: Component, Inputable {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UINumberPickerView>
    
    private final let numberTextFieldBridge: UITextFieldBridge
    
    private final let validator: UINumberPickerInputValidator
    
    private final var currentItem: UINumberPickerItem
    
    public typealias DidFailHandler = (_ error: Error) -> Void
    
    private final var didFailHandler: DidFailHandler?
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        minimumNumber: Int = 0,
        maximumNumber: Int = 99
    ) {
        
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
        
        let numberTextField = itemComponent.itemView.numberTextField!
        
        let defaultNumber = minimumNumber
        
        numberTextField.text = "\(defaultNumber)"
        
        self.itemComponent = itemComponent
        
        self.numberTextFieldBridge = UITextFieldBridge(textField: numberTextField)
        
        self.input = Observable(defaultNumber)
        
        self.currentItem = UINumberPickerItem()
        
        self.validator = UINumberPickerInputValidator(
            minimumNumber: minimumNumber,
            maximumNumber: maximumNumber
        )
        
        inputSubscription = input.subscribe {_, newValue in numberTextField.text = "\(newValue)" }
        
        numberTextFieldBridge.didEndEditing = { /* [unowned self] */ textField in
            
            let inputValue = textField.text ?? ""

            let result = self.validator.validate(value: inputValue)
            
            switch result {

            case let .success(validValue): self.input.value = validValue

            case let .failure(error):
                
                textField.text = "\(self.validator.minimumNumber)"
                
                self.didFailHandler?(error)

            }
            
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
    
    // MARK: Inputaable
    
    public final let input: Observable<Int>
    
    private final var inputSubscription: Subscription<Int>?
    
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
            input.value < validator.maximumNumber
        else { return }
        
        input.value += 1
        
    }
    
    @objc
    public final func decreaseNumber(_ sender: Any) {
        
        guard
            input.value > validator.minimumNumber
        else { return }
        
        input.value -= 1
        
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
        
        return self
        
    }
    
    @discardableResult
    public final func onDidFail(handler: DidFailHandler?) -> UINumberPickerComponent {
        
        didFailHandler = handler
        
        return self
        
    }
    
}
