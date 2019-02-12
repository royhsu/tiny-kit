//
//  MessageService.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - MessagesService

import TinyCore

struct MessagesService {
    
    let result: Result<[Message]>
    
}

// MARK: - PaginationService

import TinyKit

extension MessagesService: PaginationService {

    func fetch(
        with request: FetchRequest<Message.Cursor>,
        completion: @escaping (Result<[Message]>) -> Void
    )
    throws -> ServiceTask {
        
        completion(result)
        
        return Task()
        
    }

}

// MARK: - Task

extension MessagesService {
    
    private struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}
