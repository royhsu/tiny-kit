//
//  FetchRequest.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FetchRequest

public struct FetchRequest<Cursor> {
    
    public var fetchCursor: Cursor?
    
    public var fetchLimit: Int
    
    public init(
        fetchCursor: Cursor? = nil,
        fetchLimit: Int = 10
    ) {
        
        self.fetchCursor = fetchCursor
        
        self.fetchLimit = fetchLimit
        
    }
    
}

// MARK: - Equatable

extension FetchRequest: Equatable where Cursor: Equatable { }
