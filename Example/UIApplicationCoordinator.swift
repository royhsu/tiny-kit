//
//  UIApplicationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyKit

public final class UIApplicationCoordinator: Coordinator {

    private final let window: UIWindow

    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable

    private final var rootCoordinator: RootCoordinator

    public init(contentSize: CGSize) {

        self.window = UIWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )

        self.rootCoordinator = UILandingCoordinator(contentSize: contentSize)

    }

    public final func activate() {

        window.rootViewController = rootCoordinator.viewController

        window.makeKeyAndVisible()

        rootCoordinator.activate()

    }

}
