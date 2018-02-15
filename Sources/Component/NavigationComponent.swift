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

private final class BaseViewController: UIViewController {
    
    public final var component: Component
    
    public init(component: Component) {
        
        self.component = component
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

public final class TinyNavigationComponent: NavigationComponent {

    private final let navigationController: UINavigationController

    private final var components: [Component] = []
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        rootComponent: Component
    ) {

        self.components = [ rootComponent ]
        
        self.navigationController = UINavigationController(
            rootViewController: BaseViewController(component: rootComponent)
        )

        self.contentMode = contentMode

    }
    
    public final var topComponent: Component? { return components.last }
    
    fileprivate final func updateComponents() {
        
        var updatingComponents: [Component] = []
        
        for var component in components {
            
            component.contentMode = contentMode
            
            updatingComponents.append(component)
            
        }
        
        components = updatingComponents
        
        navigationController.setViewControllers(
            components.map(BaseViewController.init),
            animated: false
        )
        
    }
    
    // MARK: NavigationComponent

    public final func push(_ component: Component) {

        components.append(component)
        
        navigationController.pushViewController(
            BaseViewController(component: component),
            animated: true
        )
        
    }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode
    
    public final func render() {

        updateComponents()
        
        let size: CGSize

        switch contentMode {

        case .size(let width, let height):

            size = CGSize(
                width: width,
                height: height
            )

        case .automatic:

            size = topComponent?.preferredContentSize ?? .zero
            
        }
        
        var frame = navigationController.view.frame
        
        frame.size = size
        
        navigationController.view.frame = frame
        
        topComponent?.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return navigationController.view }

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
