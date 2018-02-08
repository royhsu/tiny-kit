//
//  Result.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/10/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Result

public enum Result<Value> {

    case success(Value)

    case failure(Error)

}
