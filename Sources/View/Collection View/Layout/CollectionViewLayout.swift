//
//  CollectionViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewLayout

public protocol CollectionViewLayout: AnyObject {
    
    var collectionView: View & CollectionView { get }
    
}
