//
//  UIPostImageComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostImageComponent

public final class UIPostImageComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIImageView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let imageView = UIImageView(frame: .zero)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: imageView
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        switch contentMode {
            
        case .size: break
            
        case .automatic:
            
            let width = view.bounds.width
            
            let height: CGFloat
            
            if let image = itemComponent.itemView.image {
                
                let imageAspectRatio = (image.size.width / image.size.height)
                
                height = (width / imageAspectRatio)
                
            }
            else { height = 0.0 }
            
            itemComponent.contentMode = .size(
                width: width,
                height: height
            )
            
        }
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

// MARK: - UIPostImageComponent

public extension UIPostImageComponent {
    
    @discardableResult
    public final func setImage(_ postImage: UIPostImage) -> UIPostImageComponent {
        
        let imageView = itemComponent.itemView
        
        if let image = postImage.image {
            
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
