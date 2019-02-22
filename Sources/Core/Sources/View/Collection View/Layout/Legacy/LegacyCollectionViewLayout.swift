//
//  LegacyCollectionViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacyCollectionViewLayout

public protocol LegacyCollectionViewLayout {

    var collectionView: LegacyCollectionView { get }

    init(collectionView: LegacyCollectionView)

    func invalidate()

    /// The underlying layout implementation may require a view controller as the container.
    /// The layout owner can add this as the child view controller if needed.
    var _viewController: ViewController? { get }

}
