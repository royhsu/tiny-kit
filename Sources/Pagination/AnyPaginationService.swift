//
//  AnyPaginationService.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AnyPaginationService

public struct AnyPaginationService<Element> where Element: CursorRepresentable {
    
    private let _fetch: (
        _ request: FetchRequest<Element.Cursor>,
        _ completion: @escaping (Result<[Element]>) -> Void
    )
    throws -> ServiceTask
    
    init<S>(_ service: S)
    where
        S: PaginationService,
        S.Element == Element { self._fetch = service.fetch }
    
}

// MARK: - PaginationService

extension AnyPaginationService: PaginationService {
    
    @discardableResult
    public func fetch(
        with request: FetchRequest<Element.Cursor>,
        completion: @escaping (Result<[Element]>) -> Void
    )
    throws -> ServiceTask {
        
        return try _fetch(
            request,
            completion
        )
            
    }
    
}

