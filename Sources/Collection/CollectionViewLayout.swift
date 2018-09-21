//
//  CollectionViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewLayout

public protocol CollectionViewLayout {
    
    var collectionView: View { get }
    
    func invalidateLayout()
    
    func setNumberOfSections(
        provider: @escaping (View) -> Int
    )
    
    func setNumberOfItems(
        provider: @escaping (View, _ section: Int) -> Int
    )
    
    func setViewForItem(
        provider: @escaping (View, IndexPath) -> View
    )
    
}
