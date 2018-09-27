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

    func invalidate()

    var numberOfSections: Int { get }

    func setNumberOfSections(
        _ provider: @escaping (_ collectionView: View) -> Int
    )

    func numberOfItems(atSection section: Int) -> Int

    func setNumberOfItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ section: Int
        )
        -> Int
    )

    func viewForItem(at indexPath: IndexPath) -> View

    func setViewForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPath: IndexPath
        )
        -> View
    )

}
