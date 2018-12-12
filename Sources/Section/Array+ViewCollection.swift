//
//  Array+ViewCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Template

extension Array: ViewCollection where Element == View {

    public var count: Int { return count }

    public func view(at index: Int) -> View { return self[index] }

}
