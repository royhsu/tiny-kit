//
//  Feed.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/20.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Feed

import TinyCore

public enum Feed: Decodable, Unique {

    case post(Post)

    case comment(Comment)

    private enum CodingKeys: CodingKey {

        case post

        case comment

    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let post = try? container.decode(Post.self, forKey: .post) {

            self = .post(post)

            return

        }

        if let comment = try? container.decode(Comment.self, forKey: .comment) {

            self = .comment(comment)

            return

        }

        throw FeedError.unknownFeed

    }

    public var identifier: String {

        switch self {

        case let .post(post): return post.identifier

        case let .comment(comment): return comment.identifier

        }

    }

}
