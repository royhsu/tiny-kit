//
//  Template.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Template

public protocol Template {
    
    associatedtype Element
    
    associatedtype Value
    
    func registerView(
        _ viewType: UpdatableView.Type,
        for element: Element
    )
    
    var numberOfElements: Int { get }
    
    func element(at index: Int) -> Element
    
    func view(for element: Element) -> View
    
    func updateView(
        _ view: View,
        with value: Value
    )
    
}

// MARK: - AnyTemplate

public struct AnyTemplate<Element, UpdatableView>: Template where UpdatableView: Updatable & View {

    private let _registerViewHandler: (
        _ viewType: UpdatableView.Type,
        _ element: Element
    )
    -> Void

    private let _numberOfElementsProvider: () -> Int

    private let _elementProvider: (_ index: Int) -> Element

    private let _viewProvider: (Element) -> UpdatableView

    public init<T>(_ template: T)
    where
        T: Template,
        T.Element == Element,
        T.UpdatableView == UpdatableView {

        self._registerViewHandler = template.registerView

        self._numberOfElementsProvider = { template.numberOfElements }

        self._elementProvider = template.element

        self._viewProvider = template.view

    }

    // MARK: Template

    public func registerView(
        _ viewType: UpdatableView.Type,
        for element: Element
    ) {

        _registerViewHandler(
            viewType,
            element
        )

    }

    public var numberOfElements: Int { return _numberOfElementsProvider() }

    public func element(at index: Int) -> Element { return _elementProvider(index) }

    public func view(for element: Element) -> UpdatableView { return _viewProvider(element) }

}
