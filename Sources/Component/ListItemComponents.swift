//
//  ListItemComponents.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListItemComponents

public protocol ListItemComponents {

    func numberOfSections() -> Int

    func numberOfItemsAtSection(_ section: Int) -> Int

    func componentForItem(at indexPath: IndexPath) -> Component

}
