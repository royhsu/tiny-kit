//
//  PaginationController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationController

public final class PaginationController<Element, Cursor> {
    
    private let fetchRequest: FetchRequest<Cursor>
    
    private let service: AnyPaginationService<Element, Cursor>
    
    let fetchIndexManager = PaginationIndexManager()
    
    let storage = Storage()
    
    public var elementStatesDidChange: ( (PaginationController) -> Void )?
    
    public init<S>(
        fetchRequest: FetchRequest<Cursor> = FetchRequest(),
        fetchService: S
    )
    where
        S: PaginationService,
        S.Element == Element,
        S.Cursor == Cursor {
        
        self.fetchRequest = fetchRequest
        
        self.service = AnyPaginationService(fetchService)
        
        self.load()
        
    }
    
    private func load() {
        
        storage.elementStatesDidChange = { [weak self] in
            
            guard let self = self else { return }
            
            self.elementStatesDidChange?(self)
            
        }
        
    }
    
}

extension PaginationController {
    
    public func performFetch() throws {

        let initialFetchingIndices = (0..<fetchRequest.fetchLimit)
        
        for index in initialFetchingIndices { fetchIndexManager.startFetching(for: index) }
        
        storage.elementStates = Array(
            repeating: .fetching,
            count: fetchRequest.fetchLimit
        )
        
        try service.fetch(with: fetchRequest) { [weak self] result in
            
            guard let self = self else { return }
            
            do {
                
                let page = try result.get()
                
                self.fetchIndexManager.endAllFetchings()
                
                self.storage.elementStates = page.elements.map { .fetched($0) }
                
            }
            catch {
                
                self.fetchIndexManager.endAllFetchings()
                
                self.storage.elementStates = [ .error ]
                
            }
            
        }
        
    }
    
}

extension PaginationController {
    
    public var elementStates: [ElementState] { return storage.elementStates }
    
}
