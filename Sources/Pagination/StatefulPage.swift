//
//  StatefulPage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/13.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - StatefulPage

struct StatefulPage<Cursor> {
    
    var state: State
    
    var cursor: Cursor
    
    var elementCount: Int
    
}

// MARK: - State

extension StatefulPage {
    
    enum State {
        
        case inactive, fetching
        
    }
    
}
