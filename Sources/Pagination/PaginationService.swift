//
//  PaginationService.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationService

public protocol PaginationService {
    
    associatedtype Element: CursorRepresentable
    
    @discardableResult
    func fetch(
        with request: FetchRequest<Element.Cursor>,
        completion: @escaping (Result<[Element]>) -> Void
    )
    throws -> ServiceTask
    
}
