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
        
        let listComponent = UIListComponent()
        
        let gridComponent = UIGridComponent(
            layout: UIGridLayout(
                columns: 2,
                rows: 3
            )
        )
        
        let carouselComponent = UICarouselComponent()
        
        carouselComponent.setMinimumItemWidth { _ in 200.0 }
        
        let collectionComponent: CollectionComponent = carouselComponent
        
        collectionComponent.setItemComponents(
            [
                labelComponentFactory("Cras justo odio, dapibus ac facilisis in, egestas eget quam. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam quis risus eget urna mollis ornare vel eu leo. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras mattis consectetur purus sit amet fermentum."),
                labelComponentFactory("Cras mattis consectetur purus sit amet fermentum. Nulla vitae elit libero, a pharetra augue. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."),
                labelComponentFactory("Donec id elit non mi porta gravida at eget metus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna."),
                labelComponentFactory("Nullam id dolor id nibh ultricies vehicula ut id elit."),
                labelComponentFactory("Donec sed odio dui. Curabitur blandit tempus porttitor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."),
                labelComponentFactory("Sed posuere consectetur est at lobortis. Curabitur blandit tempus porttitor."),
                labelComponentFactory("Cras justo odio, dapibus ac facilisis in, egestas eget quam. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam quis risus eget urna mollis ornare vel eu leo. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras mattis consectetur purus sit amet fermentum."),
                labelComponentFactory("Cras mattis consectetur purus sit amet fermentum. Nulla vitae elit libero, a pharetra augue. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."),
                labelComponentFactory("Donec id elit non mi porta gravida at eget metus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna."),
                labelComponentFactory("Nullam id dolor id nibh ultricies vehicula ut id elit."),
                labelComponentFactory("Donec sed odio dui. Curabitur blandit tempus porttitor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."),
                labelComponentFactory("Sed posuere consectetur est at lobortis. Curabitur blandit tempus porttitor.")
            ]
        )
        
        self.rootComponent = labelComponentFactory("Donec id elit non mi porta gravida at eget metus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna.")
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )

    }

    public final func activate() { }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}


// MARK: Example

public let colorComponentFactory: (UIColor) -> Component = { color in
    
    let colorView = UIView()
    
    colorView.backgroundColor = color
    
    let itemComponent = UIItemComponent(itemView: colorView)
    
    return itemComponent
    
}

public let exampleGridComponentFactory: () -> Component = {
    
    let gridComponent = UIGridComponent(
        layout: UIGridLayout(
            columns: 2,
            rows: 3
        )
    )
    
    gridComponent.setMinimumItemSize { _, _, _ in
        
        return CGSize(
            width: 50.0,
            height: 50.0
        )
        
    }
    
    gridComponent.layout.scrollDirection = .horizontal
    
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

public let exampleCollectionComponentFactory: () -> Component = {
    
    let collectionComponent = UICollectionComponent(
        layout: UICollectionViewFlowLayout()
    )
    
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
    
    collectionComponent.setSizeForItem { layout, indexPath in
        
        return CGSize(
            width: 150.0,
            height: 150.0
        )
        
    }
    
    return collectionComponent
    
}

public let labelComponentFactory: (String) -> Component = { text in
    
    let label = UILabel()
    
    label.text = text
    
    label.numberOfLines = 0
    
    label.backgroundColor = .red
    
    let labelComponent = UIItemComponent(itemView: label)
    
    let boxComponent = UIBoxComponent(contentComponent: labelComponent)
    
    boxComponent.paddingInsets = UIEdgeInsets(
        top: 10.0,
        left: 20.0,
        bottom: 30.0,
        right: 40.0
    )
    
    boxComponent.view.backgroundColor = .green
    
    // TODO: nested in another list component will contain expected cell height of parent cell.
//    let listComponent = UIListComponent()
//
//    listComponent.setItemComponents(
//        [ boxComponent ]
//    )
    
    return boxComponent
    
}
