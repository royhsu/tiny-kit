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
                
                #warning(
                """
                FIXME: the current implementation will ignore the next page prefetching if the previous page is fetching due to the queued indices will all be wiped out after this batch task executed.
                
                Possible strategy:
                1. Determine wether to fetch the previous / next page, and maybe even fetch both of them.
                2. Queue and prioritize the fetch request. Priority: previous > next page.
                3. Perform all queued fetch requests in order.
                """
                )
                
                guard let self = self else { return }
                
                guard let prefetchIndex = prefetchIndices.first else {
                    
                    preconditionFailure("There must contain a least one prefetch-able index.")
                    
                }
                
                if
                    self.paginationController.isPreviousPageIndex(prefetchIndex),
                    self.paginationController.hasPreviousPage {
                    
                    do {
                    
                        try self.paginationController.performFetchForPreviousPage()
                        
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
        
        paginationController.elementStatesDidChange = { [weak self] controller in
            
            guard let self = self else { return }
            
            self.elementStatesDidChange?(self)
            
        }
        
    }
    
}

extension PrefetchController {
    
    public convenience init<S>(
        fetchRequest: FetchRequest<Cursor> = FetchRequest(),
        fetchService: S
    )
    where
        S: PaginationService,
        S.Element == Element,
        S.Cursor == Cursor {

        self.init(
            fetchTimer: DefaultPrefetchBatchTimer(),
            fetchRequest: fetchRequest,
            fetchService: fetchService
        )
            
    }
    
}

extension PrefetchController {
    
    public func performFetch() throws { try paginationController.performFetch() }
    
}

extension PrefetchController {
    
    /// Setting the prefetch indices will trigger the controller to fetch the elements if they haven't been fetched.
    public var prefetchIndices: [Int] {
        
        get { return prefetchIndexManager.queue }
        
        set { prefetchIndexManager.queue.append(contentsOf: newValue) }
        
    }
    
    public var elementStates: [ElementState<Element>] { return paginationController.elementStates }
    
}
