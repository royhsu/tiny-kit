//
//  Subscription.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Subscription

public struct Subscription {
    
    public let token: String
    
    public init(token: String) { self.token = token }
    
}

// MARK: - Equatable

extension Subscription: Equatable {
    
    public static func == (
        lhs: Subscription,
        rhs: Subscription
    )
    -> Bool { return lhs.token == rhs.token }
    
}

// MARK: - Hashable

extension Subscription: Hashable {
    
    public var hashValue: Int { return token.hashValue }
    
}

