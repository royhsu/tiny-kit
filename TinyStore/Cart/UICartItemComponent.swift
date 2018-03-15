//
//  UICartItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemComponent

public final class UICartItemComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemView.self,
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

public extension UICartItemComponent {
    
    @discardableResult
    public final func setItem(_ item: UICartItem) -> UICartItemComponent {
        
        let itemView = itemComponent.itemView
        
        if let previewImage = item.previewImage {
            
            itemView.previewImageView.image = previewImage
            
            itemView.previewImageView.backgroundColor = nil
            
        }
        else {
            
            itemView.previewImageView.image = nil
            
            itemView.previewImageView.backgroundColor = .lightGray
            
        }
        
        itemView.titleLabel.text = item.title
        
        if let price = item.price {
            
            itemView.priceLabel.text = "$ \(price)"
            
        }
        else { itemView.priceLabel.text = "$" }
        
        return self
        
    }
    
}
