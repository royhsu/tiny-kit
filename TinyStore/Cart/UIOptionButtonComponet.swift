//
//  UIOptionButtonComponet.swift
//  TinyUI
//
//  Created by Roy Hsu on 19/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIOptionButtonComponet

public final class UIOptionButtonComponet: Component {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIOptionButton>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIOptionButton.self,
                from: bundle
            )!
        )
        
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
    public final func performAction(_ sender: Any) { actionHandler?() }
    
    public typealias ActionHandler = () -> Void

    private final var actionHandler: ActionHandler? 
    
}

public extension UIOptionButtonComponet {
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIOptionButtonComponet {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self
        
    }
    
    @discardableResult
    public final func setAction(_ handler: ActionHandler?) -> UIOptionButtonComponet {
        
        actionHandler = handler
        
        return self
        
    }
    
}
