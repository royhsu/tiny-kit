//
//  LegacyViewCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacyViewCollection

@available(*, deprecated: 1.0, renamed: "ViewCollection")
public protocol LegacyViewCollection {

    var count: Int { get }

    func view(at index: Int) -> View

}

extension Array: LegacyViewCollection where Element == View {
    
    public func view(at index: Int) -> View { return self[index] }
    
}
