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
    func setHeader(component: Component?) -> Self

    @discardableResult
    func setFooter(component: Component?) -> Self

}

// MARK: - IndexableGroup

// Reference: [NSIndex​Set](http://nshipster.com/nsindexset/)

public protocol IndexableGroup {

    associatedtype Element

    var numberOfSections: Int { get }

    func numberOfElements(inSection section: Int) -> Int

    func element(at indexPath: IndexPath) -> Element

}

public extension IndexableGroup {
    
    public subscript(_ indexPath: IndexPath) -> Element { return element(at: indexPath) }
    
}

// MARK: - AnyIndexableGroup

public struct AnyIndexableGroup<T>: IndexableGroup {
    
    private let _numberOfSections:  Int
    
    private let _numberOfElementsHandler: (_ section: Int) -> Int
    
    private let _elementHandler: (_ indexPath: IndexPath) -> T
    
    public init<G: IndexableGroup>(_ base: G) where G.Element == T {
        
        self._numberOfSections = base.numberOfSections
        
        self._numberOfElementsHandler = base.numberOfElements
        
        self._elementHandler = base.element
        
    }
    
    // MARK: IndexableGroup
    
    public var numberOfSections: Int { return _numberOfSections }
    
    public func numberOfElements(inSection section: Int) -> Int { return _numberOfElementsHandler(section) }
    
    public func element(at indexPath: IndexPath) -> T { return _elementHandler(indexPath) }
    
}

extension Array: IndexableGroup {
    
    public var numberOfSections: Int { return 1 }
    
    public func numberOfElements(inSection section: Int) -> Int { return count }
    
    public func element(at indexPath: IndexPath) -> Element { return self[indexPath.item] }
    
}

// MARK: - CollectionComponent

public protocol CollectionComponent: Component {

    typealias ComponentGroup = AnyIndexableGroup<Component>
    
    var itemComponentGroup: ComponentGroup { get }

    @discardableResult
    func setItemComponentGroup(_ group: ComponentGroup) -> Self

}
