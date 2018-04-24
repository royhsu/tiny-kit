//
//  UIAuthInputComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthInputComponentDelegate

public protocol UIAuthInputComponentDelegate: class {

    func component(
        _ component: Component,
        didEnter text: String
    )

}

// MARK: - UIAuthInputComponent

import TinyKit

public final class UIAuthInputComponent: Component {

    public final weak var delegate: UIAuthInputComponentDelegate? {

        didSet {

            let textField = itemComponent.itemView.textField!

            let action =
                (delegate == nil)
                ? textField.removeTarget
                : textField.addTarget

            action(
                self,
                #selector(handleInputTextChanged),
                .editingChanged
            )

        }

    }

    /// The base component.
    private final let itemComponent: UIItemComponent<UIAuthInputView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(UIAuthInputView.self)!
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

    // MARK: Action

    @objc
    public final func handleInputTextChanged(_ sender: Any) {

        guard
            let textField = sender as? UITextField
        else { return }

        let text = textField.text ?? ""

        delegate?.component(
            self,
            didEnter: text
        )

    }

}

public extension UIAuthInputComponent {

    public final func setInput(_ input: UIAuthInput?) {

        let inputView = itemComponent.itemView

        inputView.label.text = input?.name

        inputView.textField.placeholder = input?.placeholder

        inputView.textField.isSecureTextEntry = input?.isSecured ?? false

    }

}
