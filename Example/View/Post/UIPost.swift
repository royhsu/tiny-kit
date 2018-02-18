//
//  UIPost.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPost

public struct UIPost {

    public var title: String?

    public var content: String?

    public init(
        title: String? = nil,
        content: String? = nil
    ) {

        self.title = title

        self.content = content

    }

}
