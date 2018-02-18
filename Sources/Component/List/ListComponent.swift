//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

public protocol ListComponent: Component {
    
    var headerComponent: Component? { get set }
    
    var footerComponent: Component? { get set }
    
    var itemComponents: ListItemComponents? { get set }
    
}
