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
    
    private let cache: Cache
    
    public let elementStates: AnyObservable<[ElementState<Element>]?>
    
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
            
        self.cache = Cache()
        
        self.elementStates = AnyObservable(cache.elementStates)
            
        self.load()
        
    }
    
}

extension PaginationController {
    
    private func load() { cache.update(with: storage.value) }
    
    /// The controller will try to fetch the first page if there is no fetch cursor specified in the request.
    /// Re-perform the fetch has no effect on the fetching / fetched elements.
    public func performFetch() {
        
        if isDebugging {
            
            print(
                String(describing: type(of: self)),
                #function,
                "start fetching the initial page..."
            )
            
        }
        
        if isFetchPerformedForInitialPage { return }
        
        isFetchPerformedForInitialPage = true

        let fetchLimit = fetchRequest.fetchLimit
        
        cache.elementStates.modify { elementStates in
            
            elementStates = Array(repeating: .fetching, count: fetchLimit)
            
        }
        
        fetchService.fetch(with: fetchRequest) { [weak self] result in
            
            guard let self = self else { return }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
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
                
                self.storage.modify { storage in
                    
                    storage.currentPages = [ page ]
                    
                    storage.previousPage = previousPage
                    
                    storage.nextPage = nextPage
                    
                    self.cache.update(with: storage)
                    
                }
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
                        #function,
                        "an error occurs while fetching the initial page.",
                        "\(error)"
                    )
                    
                }
                
                self.cache.elementStates.modify { storage in
                    
                    storage = [ .error ]
                    
                }
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasPreviousPage` value to determine whether to fetch the previous page.
    public func performFetchForPreviousPage(
        completion: ( () -> Void )? = nil
    ) {
        
        guard isFetchPerformedForInitialPage else { preconditionFailure("The controller has not perform the initial fetch yet.") }
        
        if isFetching { preconditionFailure("The controller is still fetching.") }
        
        guard let cursor = storage.value.previousPage?.cursor else { preconditionFailure("There is no previous page curor.") }
        
        if isDebugging {
            
            print(
                String(describing: type(of: self)),
                #function,
                "start fetching the previous page with the cursor \(cursor)...",
                cursor
            )
            
        }
        
        var request = fetchRequest
        
        request.fetchCursor = cursor
        
        storage.modify { storage in
            
            storage.previousPage?.state = .fetching
            
            self.cache.update(with: storage)
            
        }
        
        let fetchLimit = request.fetchLimit
        
        fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
            defer { completion?() }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
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
                
                self.storage.modify { storage in
                    
                    storage.currentPages.insert(
                        page,
                        at: 0
                    )
                    
                    storage.previousPage = newPreviousPage
                    
                    self.cache.update(with: storage)
                    
                }
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
                        #function,
                        "an error occurs while fetching the next page.",
                        "\(error)"
                    )
                    
                }
                
                #warning("TODO: find a better way to handle the error. Should be able to re-perform the fetch for the next page.")
                self.cache.elementStates.modify { elementStates in
                    
                    elementStates = [ .error ]
                    
                }
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasNextPage` value to determine whether to fetch the next page.
    public func performFetchForNextPage(
        completion: ( () -> Void )? = nil
    ) {
        
        guard isFetchPerformedForInitialPage else { preconditionFailure("The controller has not perform the initial fetch yet.") }
        
        if isFetching { preconditionFailure("The controller is still fetching.") }
        
        guard let cursor = storage.value.nextPage?.cursor else { preconditionFailure("There is no next page curor.") }
     
        if isDebugging {
            
            print(
                String(describing: type(of: self)),
                #function,
                "start fetching the next page with the cursor \(cursor)...",
                cursor
            )
            
        }
        
        var request = fetchRequest
        
        request.fetchCursor = cursor
        
        storage.modify { storage in
            
            storage.nextPage?.state = .fetching
            
            self.cache.update(with: storage)
            
        }
        
        let fetchLimit = request.fetchLimit
        
        fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
            defer { completion?() }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
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
                
                self.storage.modify { storage in
                    
                    storage.currentPages.append(page)
                    
                    storage.nextPage = newNextPage
                    
                    self.cache.update(with: storage)
                    
                }
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self)),
                        #function,
                        "an error occurs while fetching the next page.",
                        "\(error)"
                    )
                    
                }
                
                #warning("TODO: find a better way to handle the error. Should be able to re-perform the fetch for the next page.")
                self.cache.elementStates.modify { elementStates in
                    
                    elementStates = [ .error ]
                    
                }
                
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
