//
//  TPPostParagraphComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostParagraphComponent

public final class TPPostParagraphComponent: ParagraphComponent {

    /// The base component.
    private final let boxComponent: UIBoxComponent
    
    private final let labelComponent: UIItemComponent<UILabel>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.labelComponent = UIItemComponent(
            itemView: UILabel()
        )

        self.boxComponent = UIBoxComponent(
            contentMode: contentMode,
            contentComponent: labelComponent
        )
        
        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        let textLabel = labelComponent.itemView
        
        textLabel.text = nil
        
        textLabel.textAlignment = .left
        
        textLabel.numberOfLines = 0
        
        textLabel.font = .systemFont(ofSize: 14.0)
        
        textLabel.textColor = .black

    }

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

public extension TPPostParagraphComponent {

    public final var textLabel: UILabel { return labelComponent.itemView }
    
    public final var paddingInsets: UIEdgeInsets {
        
        get { return boxComponent.paddingInsets }
        
        set { boxComponent.paddingInsets = newValue }
        
    }
    
    public final func applyTheme(_ theme: Theme) {
        
        let textLabel = labelComponent.itemView
        
        textLabel.backgroundColor = theme.backgroundColor
        
        textLabel.textColor = theme.bodyColor
        
    }

}
