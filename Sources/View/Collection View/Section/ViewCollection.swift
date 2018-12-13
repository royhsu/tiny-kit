//
//  ViewCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewCollection

public protocol ViewCollection {

    var count: Int { get }

    func view(at index: Int) -> View

}

public protocol NewViewCollection: Emptible {
    
    var count: Int { get }
    
    subscript(index: Int) -> ViewRepresentable { get }
    
}
