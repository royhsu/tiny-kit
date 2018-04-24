//
//  UIPostImageComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostImageComponent

public final class UIPostImageComponent: ImageComponent {

    /// The base component.
    private final let imageComponent: UIItemComponent<UIImageView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.imageComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIImageView()
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case let .automatic(estimatedSize): size = estimatedSize
            
        }
        
        imageView.frame.size = size

    }
    
    // MARK: ImageComponent
    
    public final var image: UIImage? {
        
        get { return imageView.image }
        
        set { imageView.image = newValue }
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return imageComponent.contentMode }

        set { imageComponent.contentMode = newValue }

    }

    public final func render() {
        
        let size: CGSize
        
        switch contentMode {

        case let .size(value): size = value

        case let .automatic(preferredSize):
            
            let width = preferredSize.width
            
            let height: CGFloat
            
            if let image = imageComponent.itemView.image {
                
                let imageAspectRatio = (image.size.width / image.size.height)
                
                height = (width / imageAspectRatio)
                
            }
            else { height = preferredSize.height }
            
            size = CGSize(
                width: width,
                height: height
            )
            
        }
        
        imageView.frame.size = size

        imageComponent.contentMode = .size(size)
        
        imageComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return imageComponent.view }

    public final var preferredContentSize: CGSize { return imageComponent.preferredContentSize }

}

// MARK: - UIPostImageComponent

public extension UIPostImageComponent {

    public final var imageView: UIImageView { return imageComponent.itemView }
    
    public final func applyTheme(_ theme: Theme) { imageComponent.itemView.backgroundColor = theme.placeholderColor }

}
