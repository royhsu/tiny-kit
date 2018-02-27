//
//  UIPrimaryButtonComponent.swift
//  TinyLanding
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPrimaryButtonComponent

public final class UIPrimaryButtonComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIPrimaryButton>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIPrimaryButton.self,
                from: bundle
            )!
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
    
}

public extension UIPrimaryButtonComponent {
    
    @discardableResult
    public final func setButtonItem(_ item: UIPrimaryButtonItem?) -> UIPrimaryButtonComponent {
        
        let buttonView = itemComponent.itemView
        
        buttonView.actionLabel.text = item?.title
        
        buttonView.actionLabel.textColor = item?.titleColor
        
        buttonView.actionView.backgroundColor = item?.backgroundColor
        
        return self
        
    }
    
}
