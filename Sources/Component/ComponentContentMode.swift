//
//  ComponentContentMode.swift
//  TinyKit
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentContentMode

public enum ComponentContentMode {

    case size(CGSize)
    
    // TODO: deprecated.
    case automatic
    
    case automatic2(estimatedSize: CGSize)

}

extension ComponentContentMode: Equatable {
    
    public static func == (
        lhs: ComponentContentMode,
        rhs: ComponentContentMode
    )
    -> Bool {
        
        switch (lhs, rhs) {
            
        case let (
            .size(lhsSize),
            .size(rhsSize)
        ): return lhsSize == rhsSize
            
        case let (
            .automatic2(lhsSize),
            .automatic2(rhsSize)
        ): return lhsSize == rhsSize
            
        default: return false
            
        }
        
    }
    
}
