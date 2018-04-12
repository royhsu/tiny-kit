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
    private final let boxComponent: UIBoxComponent
    
    private final let itemComponent: UIItemComponent<TSProductDescriptionView>
    
    public final let buttonComponent: UIButtonComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        buttonComponent: UIButtonComponent
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            itemView: UIView.load(
                TSProductDescriptionView.self,
                from: bundle
            )!
        )

        self.boxComponent = UIBoxComponent(
            contentMode: contentMode,
            contentComponent: itemComponent
        )
        
        self.buttonComponent = buttonComponent
        
        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() { itemComponent.itemView.buttonContainerView.wrapSubview(buttonComponent.view) }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {
        
        boxComponent.render()
        
        buttonComponent.render()
        
    }

    // MARK: ViewRenderable

    public final var view: View { return boxComponent.view }

    public final var preferredContentSize: CGSize { return boxComponent.preferredContentSize }

}

public extension TSProductDescriptionComponent {

    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel }
    
    public final var subtitleLabel: UILabel { return itemComponent.itemView.subtitleLabel }
    
    public final var paddingInsets: UIEdgeInsets {
        
        get { return boxComponent.paddingInsets }
        
        set { boxComponent.paddingInsets = newValue }
        
    }
    
    public final func applyTheme(_ theme: Theme) { itemComponent.itemView.applyTheme(theme) }

}
