//
//  AnyCollection+ListItemComponents.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponentDataSource

/// Each section contains a dedicated component.
extension AnyCollection: ListItemComponents {

    public func numberOfSections() -> Int {

        return lazy.flatMap { $0 as? Component }.count

    }

    public func numberOfItemsAtSection(_ section: Int) -> Int { return 1 }

    public func componentForItem(at indexPath: IndexPath) -> Component {

        let index = AnyIndex(indexPath.section)

        // swiftlint:disable force_cast
        return lazy[index] as! Component
        // swiftlint:enable force_cast

    }

}
