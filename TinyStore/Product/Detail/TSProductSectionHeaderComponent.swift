//
//  TSProductSectionHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductSectionHeaderComponent

public final class TSProductSectionHeaderComponent: Component {

    private final let bundle: Bundle

    /// The base component.
    private final let boxComponent: UIBoxComponent
    
    private final let itemComponent: UIItemComponent<TSProductSectionHeaderView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            itemView: UIView.load(
                TSProductSectionHeaderView.self,
                from: bundle
            )!
        )
        
        self.boxComponent = UIBoxComponent(
            contentMode: contentMode,
            contentComponent: itemComponent
        )
        
        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() { }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return boxComponent.contentMode }

        set { boxComponent.contentMode = newValue }

    }

    public final func render() { boxComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return boxComponent.view }

    public final var preferredContentSize: CGSize { return boxComponent.preferredContentSize }

}

public extension TSProductSectionHeaderComponent {

    public final var iconImageView: UIImageView { return itemComponent.itemView.iconImageView }
    
    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel }
    
    public final var paddingInsets: UIEdgeInsets {
        
        get { return boxComponent.paddingInsets }
        
        set { boxComponent.paddingInsets = newValue }
        
    }
    
    public final func applyTheme(_ theme: Theme) { itemComponent.itemView.applyTheme(theme) }

}
