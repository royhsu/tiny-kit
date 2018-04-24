//
//  TSStoreItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 12/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSStoreItemComponent

import TinyUI

public final class TSStoreItemComponent: Component, Stylable {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<TSStoreItemView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        theme: Theme = .current
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                TSStoreItemView.self,
                from: bundle
            )!
        )

        self.theme = theme

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let itemView = itemComponent.itemView

        itemView.applyTheme(theme)

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        let itemView = itemComponent.itemView

        itemView.applyTheme(theme)

        itemComponent.render()

        itemComponent.itemView.shadowView.updateShadow()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Stylable

    public final var theme: Theme

}

public extension TSStoreItemComponent {
    
    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel! }
    
    public final var subtitleLabel: UILabel { return itemComponent.itemView.subtitleLabel! }
    
    public final var previewImageView: UIImageView { return itemComponent.itemView.previewImageView! }
    
}
