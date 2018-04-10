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
    
    public var interitemSpacing: CGFloat
    
    public var lineSpacing: CGFloat
    
    public var scrollDirection: UICollectionViewScrollDirection
    
    public init(
        columns: Int,
        rows: Int,
        interitemSpacing: CGFloat = 0.0,
        lineSpacing: CGFloat = 0.0,
        scrollDirection: UICollectionViewScrollDirection = .vertical
    ) {
        
        self.columns = columns
        
        self.rows = rows
        
        self.interitemSpacing = interitemSpacing
        
        self.lineSpacing = lineSpacing
        
        self.scrollDirection = scrollDirection
        
    }
    
}
