//
//  UISignInComponent.swift
//  TinyAuth
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignInComponent

public final class UISignInComponent: Component {

    private final var signIn: UISignIn

    private final var emailItem: UITextInputItem
    
    private final let emailComponent: UITextInputComponent

    private final var passwordItem: UITextInputItem
    
    private final let passwordComponent: UITextInputComponent

    private final let submitComponent: UIPrimaryButtonComponent
    
    private final var submitHandler: UISignInSubmitHandler?

    /// The base component.
    private final let listComponent: UIListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        self.signIn = UISignIn()
        
        self.emailItem = UITextInputItem(
            title: NSLocalizedString(
                "Email", comment:
                ""
            ),
            placeholder: NSLocalizedString(
                "Please fill in your email address.",
                comment: ""
            )
        )
        
        self.emailComponent = UITextInputComponent()
        
        self.passwordItem = UITextInputItem(
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
            .setItem(emailItem)
            .onEdit { self.signIn.email = $0 }
        
        passwordComponent
            .setItem(passwordItem)
            .onEdit { self.signIn.password = $0 }

        submitComponent
            .setTitle(
                NSLocalizedString(
                    "Sign In",
                    comment: ""
                )
            )
            .setAction {
                
                let email = self.signIn.email ?? "Invalid"
                
                let password = self.signIn.password ?? "Invalid"
                
                self.submitHandler?(
                    email,
                    password
                )
                
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

public extension UISignInComponent {
    
    public final func setSignIn(_ signIn: UISignIn) -> UISignInComponent {
        
        self.signIn = signIn
        
        emailItem.text = signIn.email
        
        passwordItem.text = signIn.password
        
        return self
        
    }
    
    public final func onSubmit(handler: UISignInSubmitHandler? = nil) -> UISignInComponent {
        
        submitHandler = handler
        
        return self
        
    }
    
}
