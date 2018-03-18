//
//  UIGridItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 12/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridItemComponent

import TinyUI

public final class UIGridItemComponent: Component, Stylable {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIGridItemView>
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .azureSky
    ) {
        
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
        
        self.theme = theme
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let itemView = itemComponent.itemView
        
        styleTitleLabel(
            itemView.titleLabel,
            theme: theme
        )
        
        styleSubtitleLabel(
            itemView.subtitleLabel,
            theme: theme
        )
        
        stylePreviewImageView(
            itemView.previewImageView,
            theme: theme
        )
        
        itemComponent.render()
        
        itemComponent.itemView.shadowView.updateShadow()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
    fileprivate final func styleTitleLabel(
        _ label: UILabel,
        theme: Theme
    ) { label.textColor = theme.titleColor }
    
    fileprivate final func styleSubtitleLabel(
        _ label: UILabel,
        theme: Theme
    ) { label.textColor = theme.subtitleColor }
    
    fileprivate final func stylePreviewImageView(
        _ imageView: UIImageView,
        theme: Theme
    ) { imageView.backgroundColor = theme.placeholderColor }
    
}

public extension UIGridItemComponent {
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIGridItemComponent {
    
       itemComponent.itemView.titleLabel.text = title
        
        return self
        
    }
    
    @discardableResult
    public final func setSubtitle(_ subtitle: String?) -> UIGridItemComponent {
        
        itemComponent.itemView.subtitleLabel.text = subtitle
        
        return self
        
    }
    
    @discardableResult
    public final func setPreviewImages(
        _ images: [UIImage]
    )
    -> UIGridItemComponent {
        
        itemComponent.itemView.previewImageView.image = images.first
        
        itemComponent.itemView.shadowView.updateShadow()
        
        return self
        
    }
    
}
