//
//  Emoji.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Emoji

public struct Emoji: Codable {

    public var text: String?

    public init(text: String? = nil) {

        self.text = text

    }

}
