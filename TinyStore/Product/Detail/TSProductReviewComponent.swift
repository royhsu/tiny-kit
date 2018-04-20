//
//  TSProductReviewComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductReviewComponent

// TODO: The padding of box didn't behave what I expected.
public final class TSProductReviewComponent: Component {

    private final let bundle: Bundle

    /// The base component.
    private final let boxComponent: UIBoxComponent
    
    private final let itemComponent: UIItemComponent<TSProductReviewView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            itemView: UIView.load(
                TSProductReviewView.self,
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

    public final func render() {
        
        // TODO: temporarily fix background color syncing issue with item and box component.
        boxComponent.view.backgroundColor = .white
        
        boxComponent.view.layer.shadowColor = UIColor.black.cgColor
        
        boxComponent.view.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
        boxComponent.view.layer.shadowOpacity = 0.15
        
        boxComponent.view.layer.shadowRadius = 5.0
        
        boxComponent.render()
        
    }

    // MARK: ViewRenderable

    public final var view: View { return boxComponent.view }

    public final var preferredContentSize: CGSize { return boxComponent.preferredContentSize }

}

public extension TSProductReviewComponent {

    public final var pictureImageView: UIImageView { return itemComponent.itemView.pictureImageView }

    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel }

    public final var textLabel: UILabel { return itemComponent.itemView.textLabel }
    
    public final var paddingInsets: UIEdgeInsets {
        
        get { return boxComponent.paddingInsets }
        
        set { boxComponent.paddingInsets = newValue }
        
    }
    
    public final func applyTheme(_ theme: Theme) { itemComponent.itemView.applyTheme(theme) }

}
