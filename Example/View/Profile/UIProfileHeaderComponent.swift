//
//  UIProfileHeaderComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileHeaderComponent

import TinyKit

public final class UIProfileHeaderComponent: Component {

    private final let introductionComponent = UIProfileIntroductionComponent()

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

    public final func render() {

        let components: [Component] = [ introductionComponent ]

        listComponent.setItemComponents(components)
            
        listComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }

}

public extension UIProfileHeaderComponent {

    public final func setIntroduction(_ introduction: UIProfileIntroduction?) {

        introductionComponent.setIntroduction(introduction)

    }

}
