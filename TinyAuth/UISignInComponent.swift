//
//  UISignInComponent.swift
//  TinyAuth
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignInComponentDelegate

//public protocol UISignInComponentDelegate: class {
//
//    func component(
//        _ component: Component,
//        didSupplyEmail email: String,
//        password: String
//    )
//
//}

// MARK: - UISignInComponent

import TinyKit

public final class UISignInComponent: Component {

    private final var signIn = UISignIn() {

        didSet { setUpActionButton(actionComponent.itemView) }

    }

    private final let emailComponent: UITextInputComponent

    private final let passwordComponent: UITextInputComponent

    private final let actionComponent = UIItemComponent(
        itemView: UIButton(type: .system)
    )

    /// The base component.
    private final let listComponent: UIListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        self.emailComponent = UITextInputComponent()
        
        self.passwordComponent = UITextInputComponent()
        
        self.listComponent = UIListComponent(contentMode: contentMode)

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
        
        emailComponent
            .setItem(
                UITextInputItem(
                    title: NSLocalizedString(
                        "Email", comment:
                        ""
                    ),
                    placeholder: NSLocalizedString(
                        "Please fill in your email address.",
                        comment: ""
                    )
                )
            )
            .onEdit { text in
                
                print("\(text)")
                
            }
        
        passwordComponent
            .setItem(
                UITextInputItem(
                    title: NSLocalizedString(
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
            .onEdit { text in
                
                print("\(text)")
                
            }

        setUpActionButton(actionComponent.itemView)

        let components: [Component] = [
            emailComponent,
            passwordComponent,
            actionComponent
        ]

        listComponent.itemComponents = AnyCollection(components)

        listComponent.render()

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

//        delegate?.component(
//            self,
//            didSupplyEmail: email,
//            password: password
//        )

    }

}

// MARK: - UIAuthInputComponentDelegate

//extension UISignInComponent: UIAuthInputComponentDelegate {
//
//    public final func component(
//        _ component: Component,
//        didEnter text: String
//    ) {
//
//        guard
//            let component = component as? UITextInputComponent
//        else { fatalError("Unexpected component.") }
//
//        if component === emailComponent {
//
//            signIn.email = text
//
//            return
//
//        }
//
//        if component === passwordComponent {
//
//            signIn.password = text
//
//            return
//
//        }
//
//        fatalError("Unexpected input.")
//
//    }
//
//}

