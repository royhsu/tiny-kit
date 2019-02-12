//
//  MessageService.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - MessageService

import TinyCore

struct MessageService {
    
    let result: Result< Page<Message, Message.Cursor> >
    
}

// MARK: - PaginationService

import TinyKit

extension MessageService: PaginationService {

    func fetch(
        with request: FetchRequest<Message.Cursor>,
        completion: @escaping (Result< Page<Message, Message.Cursor> >) -> Void
    )
    throws -> ServiceTask {
        
        completion(result)
        
        return Task()
        
    }

}

// MARK: - Task

extension MessageService {
    
    private struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}
