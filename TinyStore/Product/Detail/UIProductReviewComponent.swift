//
//  UIProductReviewComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReviewComponent

import TinyUI

public final class UIProductReviewComponent: Component, Stylable {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductReviewView>

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
                UIProductReviewView.self,
                from: bundle
            )!
        )

        self.theme = theme

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let reviewView = itemComponent.itemView

        reviewView.applyTheme(theme)

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        let reviewView = itemComponent.itemView

        reviewView.applyTheme(theme)

        itemComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Stylable

    public final var theme: Theme

}

public extension UIProductReviewComponent {

    @discardableResult
    public final func setPictureImage(_ image: UIImage?) -> UIProductReviewComponent {

        itemComponent.itemView.pictureImageView.image = image

        return self

    }

    @discardableResult
    public final func setTitle(_ title: String?) -> UIProductReviewComponent {

        itemComponent.itemView.titleLabel.text = title

        return self

    }

    @discardableResult
    public final func setText(_ text: String?) -> UIProductReviewComponent {

        itemComponent.itemView.textLabel.text = text

        return self

    }

}
