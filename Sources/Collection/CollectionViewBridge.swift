//
//  CollectionViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewBridge

#if canImport(UIKit)

public typealias CollectionViewBridge = UICollectionViewBridge

#else

#error("No bridge for the current platform.")

#endif
