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
    
    var newCollectionView: NewCollectionView { get }
    
    init(collectionView: NewCollectionView)

    func invalidate()

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    var numberOfSections: Int { get }

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    func setNumberOfSections(
        _ provider: @escaping (_ collectionView: View) -> Int
    )

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    func numberOfItems(atSection section: Int) -> Int

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    func setNumberOfItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ section: Int
        )
        -> Int
    )

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    func viewForItem(at indexPath: IndexPath) -> View

    @available(*, deprecated: 1.0, message: "Move to CollectionViewController.")
    func setViewForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPath: IndexPath
        )
        -> View
    )

}
