//
//  UIRootCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

public final class UIRootCoordinator: Coordinator {

    private final let navigationController: UINavigationController

    private final let rootComponent: UICarouselComponent

    public init(contentSize: CGSize) {

        let rootComponent = UICarouselComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )

        let post1Component = UIPostComponent()

        post1Component.setPost(
            UIPost(
                title: "1111111",
                content: "😎"
            )
        )

        let post2Component = UIPostComponent()

        post2Component.setPost(
            UIPost(
                title: "22222222222",
                content: "😎"
            )
        )

        let post3Component = UIPostComponent()

        post3Component.setPost(
            UIPost(
                title: "333333333333333",
                content: "😎"
            )
        )

        rootComponent.itemComponents = AnyCollection(
            [
                post1Component,
                post2Component,
                post3Component
            ]
        )

        self.rootComponent = rootComponent

        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )

    }

    public final func activate() { rootComponent.render() }

}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}
