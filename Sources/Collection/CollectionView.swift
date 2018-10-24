//
//  CollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionView

public final class CollectionView: View {
    
    public var sections: SectionCollection = []
    
    public func applyLayout(_ layoutType: CollectionViewLayout.Type) {
        
        layout = layoutType.init(collectionView: self)
        
        #warning("Not sure if this invalidating is required.")
//        layout?.invalidate()
        
    }
    
    public final var layoutDidChange: (
        _ oldLayout: CollectionViewLayout?,
        _ newLayout: CollectionViewLayout?
    )
    -> Void = { _, _ in }
    
    public private(set) var layout: CollectionViewLayout? {
        
        didSet(oldLayout) {
            
            let newLayout = layout
            
            layoutDidChange(
                oldLayout,
                newLayout
            )
            
        }
        
    }
    
}
