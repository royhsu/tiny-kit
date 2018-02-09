//
//  ErrorModel.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ErrorModel

public struct ErrorModel: Codable {
    
    public var message: String?
    
    public init(message: String? = nil) { self.message = message }
    
}
