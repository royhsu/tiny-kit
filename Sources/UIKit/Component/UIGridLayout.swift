//
//  UIGridLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridLayout

public struct UIGridLayout {
    
    /// The number of columns must be greater than or equal to 1.
    public var columns: Int
    
    /// The number of rows must be greater than or equal to 1.
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
        
        if columns < 1 { fatalError("The number of columns must be greater than or equal to 1.") }
        
        if rows < 1 { fatalError("The number of rows must be greater than or equal to 1.") }
        
        self.columns = columns
        
        self.rows = rows
        
        self.interitemSpacing = interitemSpacing
        
        self.lineSpacing = lineSpacing
        
        self.scrollDirection = scrollDirection
        
    }
    
}
