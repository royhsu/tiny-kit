//
//  PrefetchController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchController

public final class PrefetchController<Element, Cursor> {
    
    private let paginationController: PaginationController<Element, Cursor>
    
    private let indexManager: PrefetchIndexManager
    
    public var elementStatesDidChange: ( (PrefetchController) -> Void )?
    
    init<S>(
        fetchTimer: PrefetchBatchTimer,
        fetchRequest: FetchRequest<Cursor> = FetchRequest(),
        fetchService: S
    )
    where
        S: PaginationService,
        S.Element == Element,
        S.Cursor == Cursor {
            
        self.indexManager = PrefetchIndexManager(
            batchTimer: fetchTimer,
            batchTask: { _, indices in
                
                print("Batch task for indices.", indices)
                
            }
        )
            
        self.paginationController = PaginationController(
            fetchRequest: fetchRequest,
            fetchService: fetchService
        )
            
        self.load()
            
    }
    
    private func load() {
    
        #warning("TODO: remove in production.")
        paginationController.isDebugging = true
        
        paginationController.willGetElement = { [weak self] _, index in
            
            guard let self = self else { return }
            
            self.indexManager.queue.append(index)
            
        }
        
        paginationController.elementStatesDidChange = { [weak self] controller in
            
            guard let self = self else { return }
            
            self.elementStatesDidChange?(self)
            
        }
        
    }
    
}

extension PrefetchController {
    
    #warning("TODO: provide a default fetch timer for public use.")
//    public init<S>(
//        fetchRequest: FetchRequest<Cursor> = FetchRequest(),
//        fetchService: S
//    )
//    where
//        S: PaginationService,
//        S.Element == Element,
//        S.Cursor == Cursor {
//
//
//    }
    
}

extension PrefetchController {
    
    public func performFetch() throws { try paginationController.performFetch() }
    
}

extension PrefetchController {
    
    public var elementStates: ElementStateArray<Element> { return paginationController.elementStates }
    
}
