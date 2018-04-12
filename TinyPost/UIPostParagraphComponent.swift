//
//  UIPostParagraphComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostParagraphComponent

public final class UIPostParagraphComponent: Component, Stylable {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<UIPostParagraphView>

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
                UIPostParagraphView.self,
                from: bundle
            )!
        )

        self.theme = theme

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let paragraphView = itemComponent.itemView

        paragraphView.applyTheme(theme)

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        let paragraphView = itemComponent.itemView

        paragraphView.applyTheme(theme)

        itemComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Stylable

    public final var theme: Theme

}

public extension UIPostParagraphComponent {

    @discardableResult
    public final func setText(_ text: String?) -> UIPostParagraphComponent {

        let paragraphView = itemComponent.itemView

        paragraphView.textLabel.text = text

        return self

    }

}
