//
//  PaginationController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationController

import TinyCore

public final class PaginationController<Element, Cursor> {
    
    private let fetchRequest: FetchRequest<Cursor>
    
    private let fetchService: AnyPaginationService<Element, Cursor>
    
    private var isFetchPerformedForInitialPage = false
    
    private let storage = Atomic(PageStorage<Element, Cursor>())
    
    var isDebugging = false
    
    private let cache = Cache()
    
    public var elementStates: AnyObservable<[ElementState<Element>]?> { return AnyObservable(cache.elementStates) }
    
    public var elementStatesDidChange: ((PaginationController) -> Void)?
    
    public init<S>(
        fetchRequest: FetchRequest<Cursor> = FetchRequest(),
        fetchService: S
    )
    where
        S: PaginationService,
        S.Element == Element,
        S.Cursor == Cursor {
        
        self.fetchRequest = fetchRequest
        
        self.fetchService = AnyPaginationService(fetchService)
        
        self.cache.update(with: storage.value)
        
    }
    
}

extension PaginationController {
    
    /// The controller will try to fetch the first page if there is no fetch cursor specified in the request.
    /// Re-perform the fetch has no effect on the fetching / fetched elements.
    public func performFetch() throws {
        
        if isDebugging {
            
            print(
                String(describing: type(of: self) ),
                #function,
                "start fetching the initial page..."
            )
            
        }
        
        if isFetchPerformedForInitialPage { return }
        
        isFetchPerformedForInitialPage = true

        let fetchLimit = fetchRequest.fetchLimit
        
        cache.elementStates.value = Array(
            repeating: .fetching,
            count: fetchLimit
        )
        
        elementStatesDidChange?(self)
        
        try fetchService.fetch(with: fetchRequest) { [weak self] result in
            
            guard let self = self else { return }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "fetch the initial page successfully.",
                        "\(page)"
                    )
                    
                }
                
                var previousPage: StatefulPage<Cursor>?
                
                if let cursor = page.previousPageCursor {
                    
                    previousPage = StatefulPage(
                        state: .inactive,
                        cursor: cursor,
                        elementCount: fetchLimit
                    )
                
                }
                
                var nextPage: StatefulPage<Cursor>?
                
                if let cursor = page.nextPageCursor {
                    
                    nextPage = StatefulPage(
                        state: .inactive,
                        cursor: cursor,
                        elementCount: fetchLimit
                    )
                
                }
                
                self.storage.modify {
                    
                    $0.currentPages = [ page ]
                    
                    $0.previousPage = previousPage
                    
                    $0.nextPage = nextPage
                    
                }
                
                self.cache.update(with: self.storage.value)
                
                self.elementStatesDidChange?(self)
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "an error occurs while fetching the initial page.",
                        "\(error)"
                    )
                    
                }
                
                self.cache.elementStates.value = [ .error ]
                
                self.elementStatesDidChange?(self)
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasPreviousPage` value to determine whether to fetch the previous page.
    public func performFetchForPreviousPage(
        completion: ( () -> Void )? = nil
    ) throws {
        
        guard isFetchPerformedForInitialPage else { preconditionFailure("The controller has not perform the initial fetch yet.") }
        
        if isFetching { preconditionFailure("The controller is still fetching.") }
        
        guard let cursor = storage.value.previousPage?.cursor else { preconditionFailure("There is no previous page curor.") }
        
        if isDebugging {
            
            print(
                String(describing: type(of: self) ),
                #function,
                "start fetching the previous page with the cursor \(cursor)...",
                cursor
            )
            
        }
        
        var request = fetchRequest
        
        request.fetchCursor = cursor
        
        storage.modify { $0.previousPage?.state = .fetching }
        
        cache.update(with: storage.value)
        
        elementStatesDidChange?(self)
        
        let fetchLimit = request.fetchLimit
        
        try fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
            defer { completion?() }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "fetch the previous page successfully.",
                        "\(page)"
                    )
                    
                }
                
                var newPreviousPage: StatefulPage<Cursor>?
                
                if let cursor = page.previousPageCursor {
                    
                    newPreviousPage = StatefulPage(
                        state: .inactive,
                        cursor: cursor,
                        elementCount: fetchLimit
                    )
                    
                }
                
                self.storage.modify {
                    
                    $0.currentPages.insert(
                        page,
                        at: 0
                    )
                    
                    $0.previousPage = newPreviousPage
                    
                }
                
                self.cache.update(with: self.storage.value)
                
                self.elementStatesDidChange?(self)
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "an error occurs while fetching the next page.",
                        "\(error)"
                    )
                    
                }
                
                #warning("TODO: find a better way to handle the error. Should be able to re-perform the fetch for the next page.")
                self.cache.elementStates.value = [ .error ]
                
                self.elementStatesDidChange?(self)
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasNextPage` value to determine whether to fetch the next page.
    public func performFetchForNextPage(
        completion: ( () -> Void )? = nil
    ) throws {
        
        guard isFetchPerformedForInitialPage else { preconditionFailure("The controller has not perform the initial fetch yet.") }
        
        if isFetching { preconditionFailure("The controller is still fetching.") }
        
        guard let cursor = storage.value.nextPage?.cursor else { preconditionFailure("There is no next page curor.") }
     
        if isDebugging {
            
            print(
                String(describing: type(of: self) ),
                #function,
                "start fetching the next page with the cursor \(cursor)...",
                cursor
            )
            
        }
        
        var request = fetchRequest
        
        request.fetchCursor = cursor
        
        storage.modify { $0.nextPage?.state = .fetching }
        
        cache.update(with: storage.value)
        
        elementStatesDidChange?(self)
        
        let fetchLimit = request.fetchLimit
        
        try fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
            defer { completion?() }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "fetch the next page successfully.",
                        "\(page)"
                    )
                    
                }
                
                var newNextPage: StatefulPage<Cursor>?
                
                if let cursor = page.nextPageCursor {
                    
                    newNextPage = StatefulPage(
                        state: .inactive,
                        cursor: cursor,
                        elementCount: fetchLimit
                    )
                    
                }
                
                self.storage.modify {
                    
                    $0.currentPages.append(page)
                    
                    $0.nextPage = newNextPage
                    
                }
                
                self.cache.update(with: self.storage.value)
                
                self.elementStatesDidChange?(self)
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "an error occurs while fetching the next page.",
                        "\(error)"
                    )
                    
                }
                
                #warning("TODO: find a better way to handle the error. Should be able to re-perform the fetch for the next page.")
                self.cache.elementStates.value = [ .error ]
                
                self.elementStatesDidChange?(self)
                
            }
            
        }
        
    }
    
}

extension PaginationController {
    
    #warning("TODO: add testing.")
    func isPreviousPageIndex(_ index: Int) -> Bool { return cache.previousPageElementStateIndices?.contains(index) ?? false }
    
    #warning("TODO: add testing.")
    func isNextPageIndex(_ index: Int) -> Bool { return cache.nextPageElementStateIndices?.contains(index) ?? false }
    
}

extension PaginationController {
    
    public var isFetching: Bool {
        
        let fetchingState = elementStates.value?.first {
            
            if case .fetching = $0 { return true }
            
            return false
            
        }
        
        return fetchingState != nil
        
    }
    
}

extension PaginationController {
    
    public var hasPreviousPage: Bool { return storage.value.hasPreviousPage }
    
    public var hasNextPage: Bool { return storage.value.hasNextPage }
    
}
