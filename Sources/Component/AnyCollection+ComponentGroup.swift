//
//  AnyCollection+ComponentGroup.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentGroup

extension AnyCollection: ComponentGroup {
    
    public func numberOfSections() -> Int { return 1 }

    public func numberOfItems(inSection section: Int) -> Int {
        
        return lazy.flatMap { $0 as? Component }.count
        
    }

    public func componentForItem(at indexPath: IndexPath) -> Component {

        let index = AnyIndex(indexPath.row)

        // swiftlint:disable force_cast
        return lazy[index] as! Component
        // swiftlint:enable force_cast

    }
    
}
