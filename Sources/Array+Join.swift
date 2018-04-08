//
//  Array+Join.swift
//  TinyCore
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Join

public extension Array {

    public func joined(separator: Element) -> Array<Element> {

        typealias Sequence = [Element]

        typealias Sequences = [Sequence]

        let sequence: JoinedSequence<Sequences> = map { [ $0 ] }
            .joined(
                separator: [ separator ]
            )

        return sequence.compactMap { $0 }

    }

}
