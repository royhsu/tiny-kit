//
//  UITextInputComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITextInputComponent

public final class UITextInputComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UITextInput>

    private final var editHandler: UITextInputEditHandler?

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        let bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UITextInput.self,
                from: bundle
            )!
        )

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        itemComponent.itemView.inputTextField.addTarget(
            self,
            action: #selector(handleEdit),
            for: .editingChanged
        )

        itemComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Action

    @objc
    public final func handleEdit(_ sender: Any) {

        guard
            let textField = sender as? UITextField
        else { return }

        let text = textField.text ?? ""

        editHandler?(text)

    }

}

public extension UITextInputComponent {

    @discardableResult
    public final func setItem(_ item: UITextInputItem) -> UITextInputComponent {

        let inputView = itemComponent.itemView

        inputView.titleLabel.text = item.title

        inputView.inputTextField.text = item.text

        inputView.inputTextField.placeholder = item.placeholder

        inputView.inputTextField.isSecureTextEntry = item.isSecured

        return self

    }

    @discardableResult
    public final func onEdit(handler: UITextInputEditHandler? = nil) -> UITextInputComponent {

        editHandler = handler

        return self

    }

}
