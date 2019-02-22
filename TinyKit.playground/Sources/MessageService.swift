//
//  MessageService.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - MessageService

import TinyCore

#warning("TODO: add testing.")
public struct MessageService {
    
    public enum Cursor {
        
        case first, middle, last
        
    }
    
    public struct Storage {
        
        public let firstPageMessages: [Message]
        
        public let middlePageMessages: [Message]?
        
        public let lastPageMessages: [Message]?
        
        public init(
            firstPageMessages: [Message],
            middlePageMessages: [Message]? = nil,
            lastPageMessages: [Message]? = nil
        ) {
           
            self.firstPageMessages = firstPageMessages
            
            self.middlePageMessages = middlePageMessages
            
            self.lastPageMessages = lastPageMessages
            
        }
        
    }
    
    public let result: Result<Storage>
    
    public init(result: Result<Storage>) { self.result = result }
    
}

// MARK: - PaginationService

import TinyKit

extension MessageService: PaginationService {

    public func fetch(
        with request: FetchRequest<Cursor>,
        completion: @escaping (Result< Page<Message, Cursor> >) -> Void
    )
    throws -> ServiceTask {
        
        let newResult = result.map { storage -> Page<Message, Cursor> in
            
            let cursor = request.fetchCursor ?? .first
            
            switch cursor {
                
            case .first:
                
                if storage.middlePageMessages != nil {
                    
                    return Page(
                        elements: storage.firstPageMessages,
                        previousPageCursor: nil,
                        nextPageCursor: .middle
                    )
                    
                }
                
                if storage.lastPageMessages != nil {
                    
                    return Page(
                        elements: storage.firstPageMessages,
                        previousPageCursor: nil,
                        nextPageCursor: .last
                    )
                    
                }
                
                throw MessageServiceError.noLastPage
                
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

public enum MessageServiceError: Error {
    
    case noMiddlePage, noLastPage
    
}

// MARK: - Task

extension MessageService {
    
    private struct Task: ServiceTask {
        
        func cancel() { }
        
    }
    
}
