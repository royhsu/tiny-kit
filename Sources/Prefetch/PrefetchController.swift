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
    
    private let fetchTimer: PrefetchBatchTimer
    
    private lazy var prefetchIndexManager: PrefetchIndexManager = {
        
        return PrefetchIndexManager(
            batchTimer: fetchTimer,
            batchTask: { [weak self] _, prefetchIndices in

                print("Batch task for indices.", prefetchIndices)
                
                guard let self = self else { return }
                
                guard let prefetchIndex = prefetchIndices.first else {
                    
                    preconditionFailure("There must contain a least one prefetch-able index.")
                    
                }
                
                if
                    self.paginationController.isPreviousPageIndex(prefetchIndex),
                    self.paginationController.hasPreviousPage {
                    
                    do {
                    
                        try self.paginationController.performFetchForNextPage()
                        
                    }
                    catch {
                        
                        #warning("TODO: error handling.")
                        print("\(error)")
                        
                    }
                    
                    return
                    
                }
                
                if
                    self.paginationController.isNextPageIndex(prefetchIndex),
                    self.paginationController.hasNextPage {
                    
                    do {
                        
                        try self.paginationController.performFetchForNextPage()
                        
                    }
                    catch {
                        
                        #warning("TODO: error handling.")
                        print("\(error)")
                        
                    }
                    
                    return
                    
                }

                preconditionFailure("Unexpected prefetch index \(prefetchIndex)")
                
            }
        )
        
    }()
    
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
        
        self.fetchTimer = fetchTimer
            
        self.paginationController = PaginationController(
            fetchRequest: fetchRequest,
            fetchService: fetchService
        )
            
        self.load()
            
    }
    
    private func load() {
    
        #warning("TODO: remove in production.")
        paginationController.isDebugging = true
        
        paginationController.willGetElementState = { [weak self] _, index, state in
            
            guard
                let self = self,
                case .inactive = state
            else { return }
            
            self.prefetchIndexManager.queue.append(index)
            
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
