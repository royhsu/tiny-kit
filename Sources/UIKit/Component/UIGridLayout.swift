//
//  UIGridLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridLayout

public struct UIGridLayout {
    
    public var columns: Int
    
    public var rows: Int
    
    public var scrollDirection: UICollectionViewScrollDirection
    
    public init(
        columns: Int,
        rows: Int,
        scrollDirection: UICollectionViewScrollDirection = .vertical
    ) {
        
        self.columns = columns
        
        self.rows = rows
        
        self.scrollDirection = scrollDirection
        
    }
    
}
