//
//  TSProductDescriptionComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductDescriptionComponent

import TinyUI

public final class TSProductDescriptionComponent: Component {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<TSProductDescriptionView>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                TSProductDescriptionView.self,
                from: bundle
            )!
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() { }

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

public extension TSProductDescriptionComponent {

    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel }
    
    public final var subtitleLabel: UILabel { return itemComponent.itemView.subtitleLabel }
    
    public final func applyTheme(_ theme: Theme) { itemComponent.itemView.applyTheme(theme) }

}
