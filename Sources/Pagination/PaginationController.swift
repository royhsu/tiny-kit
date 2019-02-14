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
    
    private let fetchService: AnyPaginationService<Element, Cursor>
    
    private var isFetchPerformedForInitialPage = false
    
    private let storage = Atomic(value: PageStorage<Element, Cursor>() )
    
    var isDebugging = false
    
    var willGetElementState: (
        (
            _ controller: PaginationController,
            _ index: Int,
            _ state: ElementState<Element>
        )
        -> Void
    )?
    
    /// A cache for certain value in the storage.
    public private(set) var elementStates: ElementStateArray<Element> {
        
        didSet {
            
            elementStates.willGetElementState = { [weak self] _, index, state in
                
                guard let self = self else { return }
                
                self.willGetElementState?(
                    self,
                    index,
                    state
                )
                
            }
            
            elementStatesDidChange?(self)
            
        }
        
    }
    
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
        
        self.fetchService = AnyPaginationService(fetchService)
            
        self.elementStates = ElementStateArray(storage.value.elementStates)
        
        self.load()
            
    }
    
    private func load() {
        
        elementStates.willGetElementState = { [weak self] _, index, state in
            
            guard let self = self else { return }
            
            self.willGetElementState?(
                self,
                index,
                state
            )
            
        }
        
    }
    
}

extension PaginationController {
    
    private final var isFetching: Bool {
        
        let fetchingState = elementStates.first {
            
            if case .fetching = $0 { return true }
            
            return false
            
        }
        
        return fetchingState != nil
        
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
        
        elementStates = ElementStateArray(
            Array(
                repeating: .fetching,
                count: fetchLimit
            )
        )
        
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
                
                self.storage.mutateValue {
                    
                    $0.currentPages = [ page ]
                    
                    $0.previousPage = previousPage
                    
                    $0.nextPage = nextPage
                    
                }
                
                self.elementStates = ElementStateArray(self.storage.value.elementStates)
                
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
                
                self.elementStates = ElementStateArray( [ .error ] )
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasPreviousPage` value to determine whether to fetch the previous page.
    public func performFetchForPreviousPage() throws {
        
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
        
        storage.mutateValue { $0.previousPage?.state = .fetching }
        
        elementStates = ElementStateArray(storage.value.elementStates)
        
        let fetchLimit = request.fetchLimit
        
        try fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
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
                
                self.storage.mutateValue {
                    
                    $0.currentPages.insert(
                        page,
                        at: 0
                    )
                    
                    $0.previousPage = newPreviousPage
                    
                }
                
                self.elementStates = ElementStateArray(self.storage.value.elementStates)
                
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
                self.elementStates = ElementStateArray( [ .error ] )
                
            }
            
        }
        
    }
    
    /// Make sure to call `performFetch()` before calling this method.
    /// You can also check the `hasNextPage` value to determine whether to fetch the next page.
    public func performFetchForNextPage() throws {
        
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
        
        storage.mutateValue { $0.nextPage?.state = .fetching }
        
        elementStates = ElementStateArray(storage.value.elementStates)
        
        let fetchLimit = request.fetchLimit
        
        try fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
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
                
                self.storage.mutateValue {
                    
                    $0.currentPages.append(page)
                    
                    $0.nextPage = newNextPage
                    
                }
                
                self.elementStates = ElementStateArray(self.storage.value.elementStates)
                
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
                self.elementStates = ElementStateArray( [ .error ] )
                
            }
            
        }
        
    }
    
}

extension PaginationController {
    
    #warning("TODO: add testing.")
    func isPreviousPageIndex(_ index: Int) -> Bool {
        
        let states = elementStates
        
        guard index < states.count else { return false }
        
        let state = states[index]
        
        switch state {
            
        case .inactive, .fetching, .error: return hasPreviousPage
        
        case .fetched: return false
            
        }
        
    }
    
    #warning("TODO: add testing.")
    func isNextPageIndex(_ index: Int) -> Bool {
        
        let states = elementStates
        
        guard index < states.count else { return false }
        
        let state = states[index]
        
        switch state {
            
        case .inactive, .fetching, .error: return hasNextPage
            
        case .fetched: return false
            
        }
        
    }
    
}

extension PaginationController {
    
    public var hasPreviousPage: Bool { return storage.value.hasPreviousPage }
    
    public var hasNextPage: Bool { return storage.value.hasNextPage }
    
}
