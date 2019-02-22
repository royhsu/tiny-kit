//
//  CollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionView

public protocol CollectionView: AnyObject {
    
    var dataSource: CollectionViewDataSource? { get set }
    
    func reloadData()
    
}
