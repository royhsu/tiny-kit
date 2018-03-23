//
//  Group.swift
//  TinyKit
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

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
