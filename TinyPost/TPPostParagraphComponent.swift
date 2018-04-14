//
//  TPPostParagraphComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostParagraphComponent

public final class TPPostParagraphComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UILabel>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UILabel()
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        let textLabel = itemComponent.itemView
        
        textLabel.text = nil
        
        textLabel.textAlignment = .left
        
        textLabel.numberOfLines = 0
        
        textLabel.font = .systemFont(ofSize: 14.0)
        
        textLabel.textColor = .black

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

public extension TPPostParagraphComponent {

    public final var textLabel: UILabel { return itemComponent.itemView }
    
    public final func applyTheme(_ theme: Theme) {
        
        let textLabel = itemComponent.itemView
        
        textLabel.backgroundColor = theme.backgroundColor
        
        textLabel.textColor = theme.bodyColor
        
    }

}
