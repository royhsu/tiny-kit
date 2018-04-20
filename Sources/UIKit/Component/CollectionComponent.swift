//
//  CollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionComponent

public protocol CollectionComponent: Component {

    var numberOfSections: Int { get set }

    func numberOfItemComponents(inSection section: Int) -> Int
    
    typealias NumberOfItemComponentsProvider = (
        _ component: Component,
        _ section: Int
    )
    -> Int

    func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider)
    
    func itemComponent(at indexPath: IndexPath) -> Component

    typealias ItemComponentProvider = (
        _ component: Component,
        _ indexPath: IndexPath
    )
    -> Component

    func setItemComponent(provider: @escaping ItemComponentProvider)

}

extension CollectionComponent {

    public func setItemComponents(
        _ components: [Component]
    ) {

        numberOfSections = 1

        setNumberOfItemComponents { _, _ in components.count }

        setItemComponent { _, indexPath in components[indexPath.item] }

    }

}
