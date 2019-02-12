//
//  Message+CursorRepresentable.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - CursorRepresentable

import TinyKit

extension Message: CursorRepresentable {
    
    var cursor: UUID { return id }
    
}
