//
//  CollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionView

#if canImport(UIKit)

import UIKit

public final class CollectionView: UICollectionView { }

#endif

public final class NewCollectionView: View {
    
    public var sections: SectionCollection = []
    
    public func applyLayout(_ layoutType: CollectionViewLayout.Type) {
        
        layout = layoutType.init(collectionView: self)
        
        #warning("Not sure if this invalidating is required.")
//        layout?.invalidate()
        
    }
    
    public private(set) var layout: CollectionViewLayout?
    
//    private typealias NumberOfSections = (_ collectionView: NewCollectionView) -> Int
//
//    private final var _numberOfSections: NumberOfSections = { _ in 1 }
//
//    public final var numberOfSections: Int { return _numberOfSections(self) }
//
//    public final func setNumberOfSections(
//        _ provider: @escaping (_ collectionView: NewCollectionView) -> Int
//    ) { _numberOfSections = provider }
//
//    public init() { super.init(frame: .zero) }
//
//    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
}
