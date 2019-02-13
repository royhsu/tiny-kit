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
        
        case first, middle, last
        
    }
    
    struct Storage {
        
        let firstPageMessages: [Message]
        
        let middlePageMessages: [Message]?
        
        let lastPageMessages: [Message]?
        
        init(
            firstPageMessages: [Message],
            middlePageMessages: [Message]? = nil,
            lastPageMessages: [Message]? = nil
        ) {
           
            self.firstPageMessages = firstPageMessages
            
            self.middlePageMessages = middlePageMessages
            
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
                    nextPageCursor: (storage.middlePageMessages == nil) ? nil : .middle
                )
                
            case .middle:
                
                guard let messages = storage.middlePageMessages else { throw MessageServiceError.noMiddlePage }
                
                if storage.lastPageMessages == nil { throw MessageServiceError.noLastPage }
                
                return Page(
                    elements: messages,
                    previousPageCursor: .first,
                    nextPageCursor: .last
                )
                
            case .last:
                
                guard let messages = storage.lastPageMessages else { throw MessageServiceError.noLastPage }
                
                return Page(
                    elements: messages,
                    previousPageCursor: (storage.middlePageMessages == nil) ? nil : .middle,
                    nextPageCursor: nil
                )
                
            }
            
        }
        
        completion(newResult)
        
        return Task()
        
    }

}

// MARK: - MessageServiceError

enum MessageServiceError: Error {
    
    case noMiddlePage, noLastPage
    
}

// MARK: - Task

extension MessageService {
    
    private struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}
