//
//  Array+Template.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Template

extension Array: Template where Element == View {
    
    public var numberOfViews: Int { return count }
    
    public func view(at index: Int) -> View { return self[index] }
    
}
