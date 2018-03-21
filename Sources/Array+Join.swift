//
//  Array+Join.swift
//  TinyKit
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Join

public extension Array {
    
    public func joined(separator: Element) -> Array<Element> {
        
        typealias Sequence = [Element]
        
        let sequence: JoinedSequence<Array<Sequence>> = map { [ $0 ] }
            .joined(
                separator: [ separator ]
            )
        
        return sequence.flatMap { $0 }
        
    }
    
}
