//
//  UIProductSectionHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductSectionHeaderComponent

public final class UIProductSectionHeaderComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductSectionHeaderView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductSectionHeaderView.self,
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

public extension UIProductSectionHeaderComponent {
    
    @discardableResult
    public final func setHeader(_ header: UIProductSectionHeader) -> UIProductSectionHeaderComponent {

        let headerView = itemComponent.itemView
        
        if let iconImage = header.iconImage {
            
            headerView.iconImageView.image = iconImage
            
            headerView.iconImageView.backgroundColor = .clear
            
        }
        else {
            
            headerView.iconImageView.image = nil
            
            headerView.iconImageView.backgroundColor = .lightGray
            
        }
        
        headerView.titleLabel.text = header.title
        
        return self

    }
    
}
