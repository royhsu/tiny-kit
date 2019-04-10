//
//  AnyPaginationService.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AnyPaginationService

import TinyCore

public struct AnyPaginationService<Element, Cursor> {
    
    private let _fetch: (
        _ request: FetchRequest<Cursor>,
        _ completion: @escaping (Result< Page<Element, Cursor> >) -> Void
    )
    throws -> ServiceTask
    
    public init<S>(_ service: S)
    where
        S: PaginationService,
        S.Element == Element,
        S.Cursor == Cursor { self._fetch = service.fetch }
    
}

// MARK: - PaginationService

extension AnyPaginationService: PaginationService {
    
    @discardableResult
    public func fetch(
        with request: FetchRequest<Cursor>,
        completion: @escaping (Result< Page<Element, Cursor> >) -> Void
    )
    throws -> ServiceTask {
        
        return try _fetch(
            request,
            completion
        )
            
    }
    
}

