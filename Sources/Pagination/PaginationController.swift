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
    
    private var isFetchPerformedForFirstPage = false
    
    let fetchIndexManager = PaginationIndexManager()
    
    private let storage = Atomic(value: PageStorage<Element, Cursor>() )
    
    #warning("Disable on the proudction mode.")
    var isDebugging = true
    
    /// The cache.
    private(set) var elementStates: [ElementState] {
        
        didSet { elementStatesDidChange?(self) }
        
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
            
        self.elementStates = storage.value.elementStates
        
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
    
    public func performFetch() throws {
        
        if isDebugging {
            
            print(
                String(
                    describing: type(of: self)
                ),
                #function,
                "start fetching the first page..."
            )
            
        }
        
        if isFetchPerformedForFirstPage { return }
        
        isFetchPerformedForFirstPage = true

        let initialFetchingIndices = (0..<fetchRequest.fetchLimit)
        
        for index in initialFetchingIndices { fetchIndexManager.startFetching(for: index) }
        
        let fetchLimit = fetchRequest.fetchLimit
        
        elementStates = Array(
            repeating: .fetching,
            count: fetchLimit
        )
        
        try fetchService.fetch(with: fetchRequest) { [weak self] result in
            
            guard let self = self else { return }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(
                            describing: type(of: self)
                        ),
                        #function,
                        "fetch elements for the first page successfully.",
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
                
                self.fetchIndexManager.endAllFetchings()
                
                self.storage.mutateValue {
                    
                    $0.currentPages = [ page ]
                    
                    $0.previousPage = previousPage
                    
                    $0.nextPage = nextPage
                    
                }
                
                self.elementStates = self.storage.value.elementStates
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(
                            describing: type(of: self)
                        ),
                        #function,
                        "an error occurs while fetching elements for the first page.",
                        "\(error)"
                    )
                    
                }
                
                self.fetchIndexManager.endAllFetchings()
                
                self.elementStates = [ .error ]
                
            }
            
        }
        
    }
    
    func performFetchForNextPage() throws {
        
        guard isFetchPerformedForFirstPage else { preconditionFailure("The controller has not perform the first fetch yet.") }
        
        if isFetching { preconditionFailure("The controller is still fetching elements.") }
        
        guard let nextPageCursor = storage.value.nextPage?.cursor else { preconditionFailure("There is no next page curor.") }
     
        if isDebugging {
            
            print(
                String(
                    describing: type(of: self)
                ),
                #function,
                "start fetching the next page...",
                nextPageCursor
            )
            
        }
        
        var request = fetchRequest
        
        request.fetchCursor = nextPageCursor
        
        storage.mutateValue { $0.nextPage?.state = .fetching }
        
        elementStates = storage.value.elementStates
        
        let fetchLimit = request.fetchLimit
        
        try fetchService.fetch(with: request) { [weak self] result in
            
            guard let self = self else { return }
            
            do {
                
                let page = try result.get()
                
                if self.isDebugging {
                    
                    print(
                        String(
                            describing: type(of: self)
                        ),
                        #function,
                        "fetch elements for the next page successfully.",
                        "\(page)"
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
                    
                    $0.currentPages.append(page)
                    
                    $0.nextPage = nextPage
                    
                }
                
                self.elementStates = self.storage.value.elementStates
                
            }
            catch {
                
                if self.isDebugging {
                    
                    print(
                        String(
                            describing: type(of: self)
                        ),
                        #function,
                        "an error occurs while fetching elements for the next page.",
                        "\(error)"
                    )
                    
                }
                
                self.fetchIndexManager.endAllFetchings()
                
                #warning("TODO: find a better way to handle the error. Should be able to re-perform the fetch for the next page.")
                self.elementStates = [ .error ]
                
            }
            
        }
        
    }
    
}

extension PaginationController {
    
    public var hasPreviousPage: Bool { return storage.value.hasPreviousPage }
    
    public var hasNextPage: Bool { return storage.value.hasNextPage }
    
}
