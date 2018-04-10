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

        self.rootComponent = UIRootCoordinator.makeGridComponent()
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )

    }

    public final func activate() { rootComponent.render() }

    // MARK: Example
    
    fileprivate static func makeGridComponent() -> Component {
        
        let gridComponent = UIGridComponent(
            layout: UIGridLayout(
                columns: 2,
                rows: 3
            )
        )
        
        let colorComponentFactory: (UIColor) -> Component = { color in
            
            let colorView = UIView()
            
            colorView.backgroundColor = color
            
            let itemComponent = UIItemComponent(itemView: colorView)
            
            return itemComponent
            
        }
        
        gridComponent.scrollDirection = .horizontal
        
        gridComponent.setItemComponents(
            [
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green)
            ]
        )
        
        return gridComponent
        
    }
    
    fileprivate static func makeCollectionComponent() -> Component {
        
        let collectionComponent = UICollectionComponent()
        
        let colorComponentFactory: (UIColor) -> Component = { color in
        
            let colorView = UIView()
            
            colorView.backgroundColor = color
            
            let itemComponent = UIItemComponent(itemView: colorView)
            
            return itemComponent
        
        }
        
//        collectionComponent.scrollDirection = .horizontal
        
        collectionComponent.setItemComponents(
            [
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green),
                colorComponentFactory(.red),
                colorComponentFactory(.green)
            ]
        )
        
        collectionComponent.sizeForItemProvider = { layout, indexPath in
            
            return CGSize(
                width: 150.0,
                height: 150.0
            )
            
        }
        
        return collectionComponent
        
    }
    
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
