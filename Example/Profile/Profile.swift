//
//  Profile.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Profile

import Foundation

public struct Profile: Codable {

    public var pictureURL: URL?

    public var name: String?

    public var introduction: String?

    public init(
        pictureURL: URL? = nil,
        name: String? = nil,
        introduction: String? = nil
    ) {

        self.pictureURL = pictureURL

        self.name = name

        self.introduction = introduction

    }

}
