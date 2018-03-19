//
//  UIOptionChainComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 19/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIOptionChainComponent

public final class UIOptionChainComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIStackView>
    
    private final var actionComponents: [UIChainableButtonComponet]
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIStackView()
        )
        
        self.actionComponents = []
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let stackView = itemComponent.itemView
        
        stackView.axis = .horizontal
        
        stackView.distribution = .fillEqually
        
    }
    
}

public extension UIOptionChainComponent {
    
    @discardableResult
    public final func setOptionDescriptors(
        _ descriptors: [UIOptionDescriptor]
    )
    -> UIOptionChainComponent {
        
        actionComponents = descriptors.map { descriptor in
            
            return UIChainableButtonComponet()
                .setTitle(descriptor.title)
                .setAction(descriptor.handler)
            
        }
        
        let stackView = itemComponent.itemView
        
        stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview)
        
        actionComponents.forEach { component in
            
            component.render()
            
            stackView.addArrangedSubview(component.view)
            
        }
        
        return self
            
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
