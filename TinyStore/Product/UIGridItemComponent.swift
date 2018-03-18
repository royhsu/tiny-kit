//
//  UIGridItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 12/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridItemComponent

public final class UIGridItemComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIGridItemView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIGridItemView.self,
                from: bundle
            )!
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        itemComponent.render()
        
        itemComponent.itemView.shadowView.updateShadow()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

public extension UIGridItemComponent {
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIGridItemComponent {
        
        let label = itemComponent.itemView.titleLabel!
    
       label.text = title
        
        return self
        
    }
    
    @discardableResult
    public final func setSubtitle(_ subtitle: String?) -> UIGridItemComponent {
        
        let label = itemComponent.itemView.subtitleLabel!
        
        label.text = subtitle
        
        return self
        
    }
    
    @discardableResult
    public final func setPreviewImages(
        _ images: [UIImage]
    )
    -> UIGridItemComponent {
        
        let imageView = itemComponent.itemView.previewImageView!
        
        if let image = images.first {
            
            imageView.image = image
            
            imageView.backgroundColor = nil
            
        }
        else {
            
            imageView.image = nil
            
            imageView.backgroundColor = .lightGray
            
        }
        
        return self
        
    }
    
}
