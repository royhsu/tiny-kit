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

    private final let rootComponent: Component

    public init(contentSize: CGSize) {

        self.rootComponent = UIRootCoordinator.makeLabelComponent()
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )

    }

    public final func activate() { rootComponent.render() }

    // MARK: Example
    
    fileprivate static func makeLabelComponent() -> Component {
        
        let listComponent = UIListComponent()
        
        let labelComponent = UIItemComponent(
            itemView: UILabel()
        )
        
        let label = labelComponent.itemView
        
        label.text = "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Cras mattis consectetur purus sit amet fermentum."
        
        label.numberOfLines = 0
        
        label.backgroundColor = .red
        
        let boxComponent = UIBoxComponent(contentComponent: labelComponent)
        
        boxComponent.paddingInsets = UIEdgeInsets(
            top: 10.0,
            left: 20.0,
            bottom: 30.0,
            right: 40.0
        )
        
        boxComponent.view.backgroundColor = .green
        
        listComponent.setItemComponents(
            [ boxComponent ]
        )
        
        return listComponent
        
    }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}
