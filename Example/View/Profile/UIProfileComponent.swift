//
//  UIProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileComponent

import TinyKit

public final class UIProfileComponent: Component {

    private final let headerComponent = UIProfileHeaderComponent(
        listComponent: UIListComponent()
    )

    /// The base component.
    private final let listComponent: ListComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        listComponent: ListComponent
    ) {

        listComponent.contentMode = contentMode

        self.listComponent = listComponent

    }

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

public extension UIProfileComponent {

    public final func setIntroduction(_ introduction: UIProfileIntroduction?) {

        headerComponent.setIntroduction(introduction)

    }

    public final func setPosts(
        _ posts: [UIPost]
    ) {

        let components: [Component] = posts.map { post in

            let component = UIPostComponent()

            component.setPost(post)

            return component

        }

        listComponent.setItem(components: components)
        
    }

}
