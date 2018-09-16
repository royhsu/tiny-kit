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
    
    associatedtype Storage
    
    var storage: Storage { get }
    
    var numberOfElements: Int { get }
    
    func view(at index: Int) -> View
    
}
