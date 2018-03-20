//
//  UIPrimaryButtonComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPrimaryButtonComponent

public final class UIPrimaryButtonComponent: Component, Stylable {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIPrimaryButton>
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIPrimaryButton.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let button = itemComponent.itemView
        
        button.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(performAction)
            )
        )
        
//        button.applyTheme(theme)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let button = itemComponent.itemView
        
//        button.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
    // MARK: Action
    
    @objc
    public final func performAction(_ sender: Any) { actionHandler?() }
    
    public typealias ActionHandler = () -> Void
    
    private final var actionHandler: ActionHandler?
    
}

public extension UIPrimaryButtonComponent {
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIPrimaryButtonComponent {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self
        
    }
    
    @discardableResult
    public final func setAction(_ handler: UIPrimaryButtonTapHandler?) -> UIPrimaryButtonComponent {
        
        actionHandler = handler
        
        return self
        
    }
    
}
