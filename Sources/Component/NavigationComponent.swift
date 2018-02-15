//
//  NavigationComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NavigationComponent

public protocol NavigationComponent: Component {

    // TODO: custom animation and ability to dsiable it.
    func push(_ component: Component)

}

public final class TinyNavigationComponent: NavigationComponent {

    private final let navigationController: UINavigationController

    private final var components: [Component] = []
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        rootComponent: Component
    ) {
        
        let testViewController = UIViewController()
        
        testViewController.view.backgroundColor = .yellow
        
        self.navigationController = UINavigationController(
            rootViewController: testViewController
        )
        
        self.components = [ rootComponent ]

        self.contentMode = contentMode

    }
    
    fileprivate final func updateComponents() {
        
        var updatingComponents: [Component] = []
        
        for var component in components {
            
            component.contentMode = contentMode
            
            updatingComponents.append(component)
            
        }
        
        components = updatingComponents
        
        let viewControllers = components.map { _ in return UIViewController() }
        
        navigationController.setViewControllers(
            viewControllers,
            animated: false
        )
        
    }
    
//    fileprivate final func show(
//        _ viewController: UIViewController,
//        with component: Component
//    ) {
//
//        component.render()
//
//        viewController.view.render(with: component)
//
//    }
    
    // MARK: NavigationComponent

    public final func push(_ component: Component) {

        components.append(component)
        
//        navigationController.pushViewController(
//            BaseViewController(component: component),
//            animated: true
//        )
        
    }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode
    
    /// Only rendering the top most component
    public final func render() {
        
        let lastIndex = components.count - 1
        
        let index =
            (lastIndex < 0)
            ? 0
            : lastIndex
        
        components[index].contentMode = contentMode
        
        components[index].render()
   
        let contentView = navigationController.viewControllers[index].view!
        
        contentView.render(
            with: components[index]
        )
        
//        navigationController.view.frame.size = viewController.view.bounds.size

    }

    // MARK: ViewRenderable

    public final var view: View { return navigationController.view }

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
