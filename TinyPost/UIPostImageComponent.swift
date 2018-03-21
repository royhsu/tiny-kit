//
//  UIPostImageComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostImageComponent

import TinyUI

public final class UIPostImageComponent: Component, Stylable {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIImageView>
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current
    ) {
        
        let imageView = UIImageView(frame: .zero)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: imageView
        )

        self.theme = theme
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let imageView = itemComponent.itemView
        
        imageView.applyTheme(theme)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        switch contentMode {
            
        case let .size(width, height):
            
            itemComponent.contentMode = .size(
                width: width,
                height: height
            )
            
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
        
        let imageView = itemComponent.itemView
        
        imageView.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
}

// MARK: - UIPostImageComponent

public extension UIPostImageComponent {
    
    @discardableResult
    public final func setImage(_ image: UIImage?) -> UIPostImageComponent {
        
        let imageView = itemComponent.itemView
        
        imageView.image = image

        return self
        
    }
    
}
