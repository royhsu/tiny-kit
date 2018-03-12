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
    public final func setItem(_ item: UIGridItem) -> UIGridItemComponent {
        
        let itemView = itemComponent.itemView

        itemView.previewImageView.image = item.previewImages.first
        
        let hasPreviewImage = (itemView.previewImageView.image != nil)
        
        itemView.previewImageView.backgroundColor =
            hasPreviewImage
            ? nil
            : .lightGray
        
        itemView.titleLabel.text = item.title
        
        itemView.subtitleLabel.text = item.subtitle
        
        return self
        
    }
    
}

// MARK: - UIGridItem

public struct UIGridItem {
    
    public var previewImages: [UIImage]
    
    public var title: String?
    
    public var subtitle: String?
    
    public init(
        previewImages: [UIImage] = [],
        title: String? = nil,
        subtitle: String? = nil
    ) {
        
        self.previewImages = previewImages
        
        self.title = title
        
        self.subtitle = subtitle
        
    }
    
}
