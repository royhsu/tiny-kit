//
//  Template.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Template

public protocol DeprecatedTemplate {
    
    associatedtype Element
    
    func registerView(
        _ viewType: View.Type,
        for element: Element
    )
    
    func numberOfElements() -> Int
    
    func element(at index: Int) -> Element
    
    func view(for element: Element) -> View
    
}

public protocol Template {
    
    associatedtype Element
    
    associatedtype Storage
    
    var storage: Storage { get }
    
    var numberOfElements: Int { get }
    
    func view(at index: Int) -> View
    
}
