//
//  UIPostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostComponent

public final class UIPostComponent: Component {

    /// The base component
    private final let listComponent: ListComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        listComponent: ListComponent
    ) {

        listComponent.contentMode = contentMode

        self.listComponent = listComponent

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() { }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return listComponent.contentMode }

        set { listComponent.contentMode = newValue }

    }

    public final func render() { listComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }

}

public extension UIPostComponent {

    @discardableResult
    public final func setPost(
        elements: [PostElement]
    )
    -> UIPostComponent {

//        let components: [Component] = elements.map { element in
//
//            switch element {
//
//            case let .text(text): return TPPostParagraphComponent().setText(text)
//
//            case let .image(image): return TPPostImageComponent().setImage(image)
//
//            }
//
//        }
//
//        // Insert spacings between elements.
//        let defaultSpacing: CGFloat = 20.0
//
//        let spacingComponent: (CGFloat) -> Component = { spacing in
//
//            return UIItemComponent(
//                contentMode: .size(
//                    CGSize(
//                        width: spacing,
//                        height: spacing
//                    )
//                ),
//                itemView: UIView()
//            )
//
//        }
//
//        let spacedComponents = components.joined(
//            separator: spacingComponent(defaultSpacing)
//        )
//
//        listComponent.setItemComponents(spacedComponents)

        return self

    }

}
