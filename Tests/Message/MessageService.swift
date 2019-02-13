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
    
    enum Cursor {
        
        case first, last
        
    }
    
    struct Storage {
        
        let firstPageMessages: [Message]
        
        let lastPageMessages: [Message]?
        
        init(
            firstPageMessages: [Message],
            lastPageMessages: [Message]? = nil
        ) {
           
            self.firstPageMessages = firstPageMessages
            
            self.lastPageMessages = lastPageMessages
            
        }
        
    }
    
    let result: Result<Storage>
    
}

// MARK: - PaginationService

import TinyKit

extension MessageService: PaginationService {

    func fetch(
        with request: FetchRequest<Cursor>,
        completion: @escaping (Result< Page<Message, Cursor> >) -> Void
    )
    throws -> ServiceTask {
        
        let newResult = result.map { storage -> Page<Message, Cursor> in
            
            let cursor = request.fetchCursor ?? .first
            
            switch cursor {
                
            case .first:
                
                return Page(
                    elements: storage.firstPageMessages,
                    previousPageCursor: nil,
                    nextPageCursor: (storage.lastPageMessages == nil) ? nil : .last
                )
                
            case .last:
                
                guard let messages = storage.lastPageMessages else { return Page() }
                
                return Page(
                    elements: messages,
                    previousPageCursor: .first,
                    nextPageCursor: nil
                )
                
            }
            
        }
        
        completion(newResult)
        
        return Task()
        
    }

}

// MARK: - Task

extension MessageService {
    
    private struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}
