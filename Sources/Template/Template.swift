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
    
    var numberOfElements: Int { get }
    
    func element(at index: Int) -> Element
    
    func view(for element: Element) -> View
    
}
