//
//  Message.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Message

import Foundation

struct Message {
    
    let id = UUID()
    
    let text: String
    
}

// MARK: - Equatable

extension Message: Equatable { }
