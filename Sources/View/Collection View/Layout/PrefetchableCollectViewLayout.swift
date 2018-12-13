//
//  PrefetchableCollectViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PrefetchableCollectViewLayout

public protocol PrefetchableCollectViewLayout: CollectionViewLayout {

    func setPrefetchingForItems(
        _ provider: @escaping (
            _ collectionView: View,
            [IndexPath]
        )
        -> Void
    )

}
