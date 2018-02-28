//
//  UISignInComponent.swift
//  TinyAuth
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignInComponent

import TinyUI
import TinyKit

public final class UISignInComponent: Component {

    private final var signIn: UISignIn

    private final let emailComponent: UITextInputComponent

    private final let passwordComponent: UITextInputComponent

    private final let submitComponent: UIPrimaryButtonComponent

    /// The base component.
    private final let listComponent: UIListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        self.signIn = UISignIn()
        
        self.emailComponent = UITextInputComponent()
        
        self.passwordComponent = UITextInputComponent()
        
        self.submitComponent = UIPrimaryButtonComponent()
        
        self.listComponent = UIListComponent(contentMode: contentMode)

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
            .onEdit { self.signIn.email = $0 }
        
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
            .onEdit { self.signIn.password = $0 }

        submitComponent
            .setItem(
                UIPrimaryButtonItem(
                    title: NSLocalizedString(
                        "Sign In",
                        comment: ""
                    ),
                    titleColor: .white,
                    backgroundColor: .black
                )
            )
            .onTap {
                
                print("Submit!", self.signIn)
                
            }

        let components: [Component] = [
            emailComponent,
            passwordComponent,
            submitComponent
        ]

        listComponent.itemComponents = AnyCollection(components)

        listComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }

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

