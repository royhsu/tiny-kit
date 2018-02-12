//
//  Message.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Message

public struct Message: Codable {

    public var text: String?

    public init(text: String? = nil) { self.text = text }

}

// MARK: - Error

public extension Message {

    public init(error: Error) { self.init(text: "\(error)") }

}
