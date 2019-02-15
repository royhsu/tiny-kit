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
    
    private let prefetchTimer: PrefetchBatchTimer
    
    private let prefetchTaskManager = PrefetchTaskManager()
    
    private lazy var prefetchIndexManager: PrefetchIndexManager = {
        
        return PrefetchIndexManager(
            batchTimer: prefetchTimer,
            batchTask: { [weak self] _, prefetchIndices in

                print("Batch task for indices.", prefetchIndices)
                
                guard let self = self else { return }
                
                if self.prefetchTaskManager.isExecutingTasks { return }
                
                guard let prefetchIndex = prefetchIndices.first else {
                    
                    preconditionFailure("There must contain a least one prefetch-able index.")
                    
                }
                
                if
                    self.paginationController.isPreviousPageIndex(prefetchIndex),
                    self.paginationController.hasPreviousPage {
                    
                    self.prefetchTaskManager.tasks[.previous] = { _, completion in
                    
                        do { try self.paginationController.performFetchForPreviousPage(completion: completion) }
                        catch {
                            
                            #warning("TODO: error handling.")
                            print("\(error)")
                            
                            completion()
                            
                        }
                        
                    }
                    
                }
                
                if
                    self.paginationController.isNextPageIndex(prefetchIndex),
                    self.paginationController.hasNextPage {
                    
                    self.prefetchTaskManager.tasks[.next] = { _, completion in
                    
                        do { try self.paginationController.performFetchForNextPage(completion: completion) }
                        catch {
                            
                            #warning("TODO: error handling.")
                            print("\(error)")
                            
                            completion()
                            
                        }
                        
                    }
                    
                }
                
                if self.prefetchTaskManager.tasks.isEmpty { return }
                
                self.prefetchTaskManager.executeAllTasks()
                
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
        
        self.prefetchTimer = fetchTimer
            
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
    
    public var isFetching: Bool { return paginationController.isFetching }
    
    /// Set the prefetch indices will trigger the controller to fetch the elements if they haven't been fetched.
    /// Beware of some potential performance issue may happen if the caller doesn't handle queuing indices well.
    public var prefetchIndices: [Int] {
        
        get { return prefetchIndexManager.queue }
        
        set { prefetchIndexManager.queue.append(contentsOf: newValue) }
        
    }
    
    public var elementStates: [ElementState<Element>] { return paginationController.elementStates }
    
}
