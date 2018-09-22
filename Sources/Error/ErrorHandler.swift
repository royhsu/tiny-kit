//
//  ErrorHandler.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/22.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ErrorHandler

public protocol ErrorHandler: AnyObject {
    
    func `catch`(error: Error)
    
}
