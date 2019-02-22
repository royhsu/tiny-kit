//
//  CursorRepresentable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - CursorRepresentable

public protocol CursorRepresentable {
    
    associatedtype Cursor
    
    var cursor: Cursor { get }
    
}
