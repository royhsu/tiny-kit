//
//  Post.swift
//  TinyPost
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Post

public struct Post {

    public var elements: [PostElement]

    public init(
        elements: [PostElement] = []
    ) { self.elements = elements }

}
