//
//  Failable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Failable

import TinyCore

public protocol Failable {
    
    var errors: Observable<Error> { get }
    
}
