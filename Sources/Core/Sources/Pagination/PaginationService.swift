//
//  PaginationService.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationService

import TinyCore

public protocol PaginationService {
    
    associatedtype Element
    
    associatedtype Cursor
    
    @discardableResult
    func fetch(
        with request: FetchRequest<Cursor>,
        completion: @escaping (Result<Page<Element, Cursor>, Error>) -> Void
    )
    -> ServiceTask
    
}
