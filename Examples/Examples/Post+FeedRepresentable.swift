//
//  Post+FeedRepresentable.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/20.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FeedRepresentable

extension Post: FeedRepresentable {

    public var feed: Feed { return .post(self) }

}
