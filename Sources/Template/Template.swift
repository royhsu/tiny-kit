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
    
    func registerView(
        _ viewType: View.Type,
        for element: Element
    )
    
    func numberOfElements() -> Int
    
    func element(at index: Int) -> Element
    
    func view(for element: Element) -> View
    
}

// MARK: - AnyTemplate

public struct AnyTemplate<Element>: Template {
    
    private typealias RegisterViewHandler = (
        _ viewType: View.Type,
        _ element: Element
    )
    -> Void
    
    private let _registerViewHandler: RegisterViewHandler
    
    private let _numberOfElementsProvider: () -> Int
    
    private let _elementProvider: (_ index: Int) -> Element
    
    private let _viewProvider: (_ element: Element) -> View

    public init<T>(_ template: T) where T: Template, T.Element == Element {
        
        self._registerViewHandler = template.registerView
        
        self._numberOfElementsProvider = template.numberOfElements
        
        self._elementProvider = template.element
        
        self._viewProvider = template.view
        
    }
    
    public func registerView(
        _ viewType: View.Type,
        for element: Element
    ) {
        
        _registerViewHandler(
            viewType,
            element
        )
        
    }
    
    public func numberOfElements() -> Int { return _numberOfElementsProvider() }
    
    public func element(at index: Int) -> Element { return _elementProvider(index) }
    
    public func view(for element: Element) -> View { return _viewProvider(element) }
    
}
