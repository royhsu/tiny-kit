//
//  UISignInComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignInComponentDelegate

public protocol UISignInComponentDelegate: class {

    func component(
        _ component: Component,
        didSupplyEmail email: String,
        password: String
    )

}

// MARK: - UISignInComponent

import TinyKit

public final class UISignInComponent: Component {

    // TODO: add state machine for managing the validation of inputs.

    public final weak var delegate: UISignInComponentDelegate?

    private final var signIn = UISignIn() {

        didSet { setUpActionButton(actionComponent.itemView) }

    }

    private final let emailComponent = UIAuthInputComponent()

    private final let passwordComponent = UIAuthInputComponent()

    private final let actionComponent = UIItemComponent(
        itemView: UIButton(type: .system)
    )

    /// The base component.
    private final let listComponent: ListComponent

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        listComponent: ListComponent
    ) {

        listComponent.contentMode = contentMode

        self.listComponent = listComponent

    }

    // MARK: Set Up

    fileprivate final func setUpActionButton(_ button: UIButton) {

        button.setTitle(
            NSLocalizedString(
                "Sign In",
                comment: ""
            ),
            for: .normal
        )

        button.addTarget(
            self,
            action: #selector(handleActionButtonClicked),
            for: .touchUpInside
        )

        let isValid: Bool

        if
            let email = signIn.email,
            !email.isEmpty,
            let password = signIn.password,
            !password.isEmpty { isValid = true }
        else { isValid = false }

        button.isEnabled = isValid

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return listComponent.contentMode }

        set { listComponent.contentMode = newValue }

    }

    public final func render() {

        emailComponent.setInput(
            UIAuthInput(
                name: NSLocalizedString(
                    "Email", comment:
                    ""
                ),
                placeholder: NSLocalizedString(
                    "Please fill in your email address.",
                    comment: ""
                )
            )
        )

        emailComponent.delegate = self

        passwordComponent.setInput(
            UIAuthInput(
                name: NSLocalizedString(
                    "Password", comment:
                    ""
                ),
                placeholder: NSLocalizedString(
                    "Please fill in your password.",
                    comment: ""
                ),
                isSecured: true
            )
        )

        passwordComponent.delegate = self

        setUpActionButton(actionComponent.itemView)

        let components: [Component] = [
            emailComponent,
            passwordComponent,
            actionComponent
        ]

        listComponent.setItemComponents(components)
            
        listComponent
            .render()

    }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }

    // MARK: Action

    @objc
    public final func handleActionButtonClicked(_ sender: Any) {

        guard
            let email = signIn.email,
            let password = signIn.password
        else { fatalError("The input is invalid.") }

        delegate?.component(
            self,
            didSupplyEmail: email,
            password: password
        )

    }

}

// MARK: - UIAuthInputComponentDelegate

extension UISignInComponent: UIAuthInputComponentDelegate {

    public final func component(
        _ component: Component,
        didEnter text: String
    ) {

        guard
            let component = component as? UIAuthInputComponent
        else { fatalError("Unexpected component.") }

        if component === emailComponent {

            signIn.email = text

            return

        }

        if component === passwordComponent {

            signIn.password = text

            return

        }

        fatalError("Unexpected input.")

    }

}
