//
//  Result.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Result

public enum Result<T> {
    
    case success(T)
    
    case failure(Error)
    
}
