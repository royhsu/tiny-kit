//
//  UISignInComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignInComponent

import TinyKit

public final class UISignInComponent: Component {
    
    private final let emailComponent = UIAuthInputComponent()
    
    private final let passwordComponent = UIAuthInputComponent()
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
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
        
        let components: [Component] = [
            emailComponent,
            passwordComponent
        ]
        
        listComponent.itemComponents = AnyCollection(components)
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

// MARK: - UIAuthInputComponentDelegate

extension UISignInComponent: UIAuthInputComponentDelegate {
    
    public final func component(
        _ component: UIAuthInputComponent,
        didEnter text: String
    ) {
        
        print(text)
        
    }
    
}
