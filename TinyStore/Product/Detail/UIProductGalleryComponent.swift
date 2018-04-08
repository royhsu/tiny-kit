//
//  UIProductGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductGalleryComponent

import TinyUI

public final class UIProductGalleryComponent: Component, Stylable {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductGalleryView>

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
                UIProductGalleryView.self,
                from: bundle
            )!
        )

        self.theme = theme

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let galleryView = itemComponent.itemView

        galleryView.applyTheme(theme)

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        let galleryView = itemComponent.itemView

        galleryView.applyTheme(theme)

        itemComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Stylable

    public final var theme: Theme

}

public extension UIProductGalleryComponent {

    @discardableResult
    public final func setImages(
        _ images: [UIImage]
    )
    -> UIProductGalleryComponent {

        let galleryView = itemComponent.itemView

        galleryView.imageView.image = images.first

        // NOTE: The added image will cover up the triangle view.
        galleryView.bringSubview(toFront: galleryView.triangleView)

        return self

    }

}
