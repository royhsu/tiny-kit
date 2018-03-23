//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

/// The layout component that renders the group of item components into a list.
public protocol ListComponent: CollectionComponent {

    var headerComponent: Component? { get }

    var footerComponent: Component? { get }

    @discardableResult
    func setHeaderComponent(_ component: Component?) -> Self

    @discardableResult
    func setFooterComponent(_ component: Component?) -> Self

}
