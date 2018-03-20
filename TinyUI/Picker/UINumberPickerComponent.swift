//
//  UINumberPickerComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerComponent

public final class UINumberPickerComponent: Component, Stylable, Inputable {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UINumberPicker>
    
    private final let validator: UINumberPickerInputValidator
    
    private final let numberTextFieldBridge: UITextFieldBridge
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current,
        inputValue: Int? = nil,
        minimumValue: Int = 0,
        maximumValue: Int = 10
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UINumberPicker.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        let defaultValue = inputValue ?? minimumValue

        self.input = Observable(defaultValue)

        self.validator = UINumberPickerInputValidator(
            minimumValue: minimumValue,
            maximumValue: maximumValue
        )
        
        self.numberTextFieldBridge = UITextFieldBridge(
            textField: itemComponent.itemView.numberTextField
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let picker = itemComponent.itemView
        
        setUpPickerNumberTextField(
            picker.numberTextField,
            value: input.value
        )
        
        setUpPickerNumberTextField(
            picker.numberTextField,
            toolBar: UIToolbar()
        )
        
        inputSubscription = input.subscribe { [unowned self] _, value in
            
            self.setUpPickerNumberTextField(
                picker.numberTextField,
                value: value
            )
            
        }

        numberTextFieldBridge.didEndEditing = { [unowned self] textField in

            let inputValue = textField.text ?? ""

            let result = self.validator.validate(value: inputValue)

            switch result {

            case let .success(validValue): self.input.value = validValue

            case let .failure(error):

                textField.text = "\(self.validator.minimumValue)"

                self.didFailHandler?(error)

            }

        }
        
        picker.increaseContainerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(increaseValue)
            )
        )
        
        picker.decreaseContainerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(decreaseValue)
            )
        )
        
        picker.applyTheme(theme)
        
    }
    
    fileprivate final func setUpPickerNumberTextField(
        _ textField: UITextField,
        value: Int
    ) { textField.text = "\(value)" }
    
    fileprivate final func setUpPickerNumberTextField(
        _ textField: UITextField,
        toolBar: UIToolbar
    ) {
        
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
    
    public final func render() {
        
        itemComponent.itemView.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
    // MARK: Inputaable
    
    public final let input: Observable<Int>
    
    private final var inputSubscription: Subscription<Int>?
    
    // MARK: Action
    
    @objc
    public final func increaseValue(_ sender: Any) {
        
        guard
            input.value < validator.maximumValue
        else { return }
        
        input.value += 1
        
    }
    
    @objc
    public final func decreaseValue(_ sender: Any) {
        
        guard
            input.value > validator.minimumValue
        else { return }
        
        input.value -= 1
        
    }
    
    @objc
    public final func dismissKeyboard(_ sender: Any) { view.endEditing(true) }
    
    public typealias DidFailHandler = (Error) -> Void
    
    private final var didFailHandler: DidFailHandler?
    
}

public extension UINumberPickerComponent {
    
    @discardableResult
    public final func setDidFail(_ handler: DidFailHandler?) -> UINumberPickerComponent {
        
        didFailHandler = handler
        
        return self
        
    }
    
}
