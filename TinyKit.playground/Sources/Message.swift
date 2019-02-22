//
//  Message.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Message

public struct Message {
    
    public let text: String
    
    public init(text: String) { self.text = text }
    
}

// MARK: - Equatable

extension Message: Equatable { }
