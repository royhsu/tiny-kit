//
//  PostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 2018/4/15.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostComponent

public protocol PostComponent: Component {
    
    var numberOfElements: Int { get set }
    
    func element(at index: Int) -> Element
    
    typealias ElementProvider = (_ index: Int) -> Element
    
    func setElement(provider: @escaping ElementProvider)
    
}

public extension PostComponent {
    
    public func setElements(
        _ elements: [Element]
    ) {
        
        numberOfElements = elements.count
        
        setElement { index in elements[index] }
        
    }
    
}
