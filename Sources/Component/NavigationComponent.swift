//
//  NavigationComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NavigationComponent

//public protocol NavigationComponent: Component {
//    
//    func push(_ component: Component)
//    
//}
//
//public final class TinyNavigationComponent: NavigationComponent {
//    
//    private final let navigationController: UINavigationController
//    
//    public init(
//        contentMode: ComponentContentMode = .automatic,
//        rootComponent: Component
//    ) {
//        
//        self.navigationController = UINavigationController(
//            rootViewController: RootViewController(renderable: rootComponent)
//        )
//        
//        self.contentMode = contentMode
//        
//    }
//    
//    public func push(_ component: Component) {
//        
//    }
//    
//    
//    
//    public final var contentMode: ComponentContentMode
//    
//    public final func render() {
//        
//        let size: CGSize
//        
//        switch contentMode {
//            
//        case .size(let width, let height):
//            
//            size = CGSize(
//                width: width,
//                height: height
//            )
//            
//        case .automatic:
//            
//            
//        }
//        
//    }
//    
//    // MARK: ViewRenderable
//    
//    public final var view: View { return navigationController.view }
//    
//    public final var preferredContentSize: CGSize { return view.bounds.size }
//    
//}

