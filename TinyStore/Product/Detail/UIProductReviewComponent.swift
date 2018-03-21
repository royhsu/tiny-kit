//
//  UIProductReviewComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReviewComponent

public final class UIProductReviewComponent: Component {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductReviewView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductReviewView.self,
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

public extension UIProductReviewComponent {
    
    @discardableResult
    public final func setPictureImage(_ image: UIImage?) -> UIProductReviewComponent {
        
        itemComponent.itemView.pictureImageView.image = image
        
        return self
        
    }
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIProductReviewComponent {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self
            
    }
    
    @discardableResult
    public final func setText(_ text: String?) -> UIProductReviewComponent {
        
        itemComponent.itemView.textLabel.text = text
        
        return self
        
    }
    
}
