//
//  Review.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Review

import TinyKit

public struct Review {

    public let imageContainer: ImageContainer?

    public let title: String?

    public let text: String?

    public init(
        imageContainer: ImageContainer? = nil,
        title: String? = nil,
        text: String? = nil
    ) {

        self.imageContainer = imageContainer

        self.title = title

        self.text = text

    }

}
