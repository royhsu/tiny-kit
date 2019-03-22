//
//  FormField+Codable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Codable

extension FormField: Codable where Value: Codable {
    
    public convenience init(from decoder: Decoder) throws {
    
        let container = try decoder.singleValueContainer()
        
        let initialValue = try container.decode(Value.self)
        
        self.init(initialValue)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
        let validValue = try validateIfNeeded()
        
        var container = encoder.singleValueContainer()
        
        try container.encode(validValue)
        
    }
    
}
