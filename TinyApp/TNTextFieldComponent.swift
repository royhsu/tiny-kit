//
//  TNTextFieldComponent.swift
//  TinyApp
//
//  Created by Roy Hsu on 2018/5/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TNTextFieldComponent

import TinyCore
import TinyKit

public final class TNTextFieldComponent: Component {
    
    /// The base component.
    private final let textFieldComponent: UIItemComponent<UITextField>
    
    public final let input: Observable<String>
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.textFieldComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UITextField()
        )
        
        self.input = Observable("")
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    private final func prepare() {
        
        textField.backgroundColor = .red
        
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return textFieldComponent.contentMode }
        
        set { textFieldComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        textFieldComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return textFieldComponent.view }
    
    public final var preferredContentSize: CGSize { return textFieldComponent.preferredContentSize  }
    
    // MARK: Observer
    
    @objc
    public final func textDidChange(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        
        input.value = text
        
    }
    
}

public extension TNTextFieldComponent {
    
    public final var textField: UITextField { return textFieldComponent.itemView }
    
}
