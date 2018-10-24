//
//  CollectionViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewLayout

public protocol CollectionViewLayout {

    var collectionView: CollectionView { get }
    
    init(collectionView: CollectionView)

    func invalidate()
    
    /// The underlying layout implementation may require a view controller as the container.
    /// The layout owner can add this as the child view controller if needed.
    var _viewController: ViewController? { get }

}
