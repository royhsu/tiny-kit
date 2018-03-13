//
//  UIProductDescriptionComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescriptionComponent

// TODO: CANNOT automatically self-sizing. Need to investigate deeply.
public final class UIProductDescriptionComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductDescriptionView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductDescriptionView.self,
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

public extension UIProductDescriptionComponent {
    
    @discardableResult
    public final func setTitle(_ title: UIProductDescription) -> UIProductDescriptionComponent {
        
        let titleView = itemComponent.itemView
        
        titleView.titleLabel.text = title.title
        
        titleView.subtitleLabel.text = title.subtitle
        
        return self
        
    }
    
}

