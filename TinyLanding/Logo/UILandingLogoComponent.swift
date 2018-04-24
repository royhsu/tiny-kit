//
//  UILandingLogoComponent.swift
//  TinyLanding
//
//  Created by Roy Hsu on 28/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingLogoComponent

public final class UILandingLogoComponent: Component {

    /// The base component.
    public final let itemComponent: UIItemComponent<UILandingLogoView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        let bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UILandingLogoView.self,
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

public extension UILandingLogoComponent {

    @discardableResult
    public final func setLogo(_ logo: UILandingLogo) -> UILandingLogoComponent {

        let logoView = itemComponent.itemView

        logoView.logoImageView.image = logo.logoImage

        logoView.backgroundImageView.image = logo.backgroundImage

        logoView.backgroundColor = logo.backgroundColor

        return self

    }

}
