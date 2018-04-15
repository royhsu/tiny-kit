//
//  TPPostImageComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostImageComponent

// TODO: find a better way to specify the width of image view.
public final class TPPostImageComponent: ImageComponent {

    /// The base component.
    private final let imageComponent: UIItemComponent<UIImageView>

    public init(
        contentMode: ComponentContentMode = .automatic,
        width: CGFloat
    ) {

        self.imageComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIImageView(
                frame: CGRect(
                    x: 0.0,
                    y: 0.0,
                    width: width,
                    height: 0.0
                )
            )
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let imageView = imageComponent.itemView
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return imageComponent.contentMode }

        set { imageComponent.contentMode = newValue }

    }

    public final func render() {
        
        let imageView = imageComponent.itemView

        let size: CGSize
        
        switch contentMode {

        case let .size(value): size = value

        case .automatic:

            let width = imageView.bounds.width

            let height: CGFloat

            if let image = imageComponent.itemView.image {

                let imageAspectRatio = (image.size.width / image.size.height)

                height = (width / imageAspectRatio)

            }
            else { height = 0.0 }

            size = CGSize(
                width: width,
                height: height
            )

        }

        imageComponent.contentMode = .size(size)
        
        imageComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return imageComponent.view }

    public final var preferredContentSize: CGSize { return imageComponent.preferredContentSize }

}

// MARK: - UIPostImageComponent

public extension TPPostImageComponent {

    public final var imageView: UIImageView { return imageComponent.itemView }
    
    public final func applyTheme(_ theme: Theme) { imageComponent.itemView.backgroundColor = theme.placeholderColor }

}
