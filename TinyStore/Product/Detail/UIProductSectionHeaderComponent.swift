//
//  UIProductSectionHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductSectionHeaderComponent

import TinyUI

public final class UIProductSectionHeaderComponent: Component, Stylable {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductSectionHeaderView>
    
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
                UIProductSectionHeaderView.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let headerView = itemComponent.itemView
        
        headerView.applyTheme(theme)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let headerView = itemComponent.itemView
        
        headerView.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
}

public extension UIProductSectionHeaderComponent {
    
    @discardableResult
    public final func setIconImage(_ image: UIImage?) -> UIProductSectionHeaderComponent {
        
        itemComponent.itemView.iconImageView.image = image
        
        return self
        
    }
    
    @discardableResult
    public final func setTitle(_ title: String) -> UIProductSectionHeaderComponent {
        
        itemComponent.itemView.titleLabel.text = title
        
        return self

    }
    
}
