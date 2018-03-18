//
//  UIApplicationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyAuth

public final class UIApplicationCoordinator: Coordinator {

    /// The navigator.
    private final let window: TestWindow

    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable

    private final var rootCoordinator: RootCoordinator
    
    public init(contentSize: CGSize) {

        self.window = TestWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )
        
        self.rootCoordinator = UIHomeNavigationCoordinator()
        
    }

    public final func activate() {

        window.rootViewController = rootCoordinator.viewController
        
        window.makeKeyAndVisible()

        rootCoordinator.activate()

    }

}

public final class TestWindow: UIWindow {
    
    public override func sendEvent(_ event: UIEvent) {
        
        event.touches(for: self)?.forEach { touch in
            
            let point = touch.location(in: self)
            
            let view = hitTest(
                point,
                with: event
            )

        }
        
        super.sendEvent(event)
        
    }
    
}
