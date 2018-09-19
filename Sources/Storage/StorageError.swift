//
//  StorageError.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/19.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StorageError

public enum StorageError<Key>: Error {
    
    case valueNotFound(key: Key)
    
}
