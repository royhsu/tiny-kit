//
//  CollectionViewDataSource.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewDataSource

public protocol CollectionViewDataSource: AnyObject {
    
    var sections: SectionCollection { get }
    
}
