//
//  CollectionViewCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewCell

#if canImport(UIKit)

import UIKit

public typealias CollectionViewCell = UICollectionViewCell

#else

public final class CollectionViewCell: View { }

#endif
