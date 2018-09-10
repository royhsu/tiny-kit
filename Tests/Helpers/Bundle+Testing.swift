//
//  Bundle+Testing.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Testing

import Foundation

public extension Bundle {
    
    public static var test: Bundle { return Bundle(for: self) }
    
}
