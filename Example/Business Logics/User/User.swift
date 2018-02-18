//
//  User.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - User

import Foundation

public struct User {

    public var pictureURL: URL?

    public var name: String

    public var introduction: String?

    public init(
        pictureURL: URL? = nil,
        name: String,
        introduction: String? = nil
    ) {

        self.pictureURL = pictureURL

        self.name = name

        self.introduction = introduction

    }

}
