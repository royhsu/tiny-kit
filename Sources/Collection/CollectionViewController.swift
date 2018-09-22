//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

import TinyStorage
import TinyCore

open class CollectionViewController<S, C, U>: ViewController
where
    S: Storage,
    C: SectionCollection,
    U: SectionCollection {
    
    public typealias Reducer = (S) -> C
    
    private final var obervation: Observation?
    
    public final var layout: CollectionViewLayout? {
        
        didSet {
            
            if let collectionView = layout?.collectionView {
                
                view.subviews.forEach { $0.removeFromSuperview() }
                
                view.wrapSubview(collectionView)
                
            }
            
            layout?.setNumberOfSections { [weak self] _ in self?.sections?.count ?? 0 }
    
            layout?.setNumberOfItems { [weak self] _, section in
    
                return self?.sections?.numberOfElements(at: section) ?? 0
    
            }
    
            layout?.setViewForItem { [weak self] _, indexPath in
    
                guard
                    let view = self?.sections?.view(at: indexPath)
                else { return View() }
    
                return view
    
            }
            
            if let prefetchableLayout = layout as? PrefetchableCollectViewLayout {
                
                prefetchableLayout.setPrefetchingForItems { [weak self] _, indexPaths in
                    
                    #warning("FIXME: The loading more won't trigger while the displayed cells were too few.")
                    guard
                        let self = self,
                        let lastIndexPath = indexPaths.max(),
                        let lastState = self.sections?.state(at: lastIndexPath.section),
                        case .prefetching = lastState
                    else { return }
                    
                    print("Loading more...")
                    
                    self.loadStorage()
                    
                }
                
            }
            
            layout?.invalidateLayout()
            
        }
        
    }
    
    private struct Sections {
        
        enum State {
            
            case fetched(C.Section)
            
            case prefetching(U.Section)
            
        }
        
        let fetchedSections: AnySectionCollection<C.Section>?
        
        let prefetchingSections: AnySectionCollection<U.Section>?
        
        init(
            fetchedSections: C?,
            prefetchingSections: U?
        ) {
            
            if let fetchedSections = fetchedSections {
                
                self.fetchedSections = AnySectionCollection(fetchedSections)
                
            }
            else { self.fetchedSections = nil }
            
            if
                let prefetchingSections = prefetchingSections,
                !prefetchingSections.isEmpty
            {
            
                self.prefetchingSections = AnySectionCollection(prefetchingSections)
                
            }
            else { self.prefetchingSections = nil }
            
        }
        
        var count: Int {
            
            let fetchedCount = fetchedSections?.count ?? 0
            
            let prefetchingCount = prefetchingSections?.count ?? 0
            
            return fetchedCount + prefetchingCount
            
        }
        
        func numberOfElements(at section: Int) -> Int {
            
            switch state(at: section) {
                
            case let .fetched(section): return section.numberOfElements
                
            case let .prefetching(section): return section.numberOfElements
                
            }
            
        }
        
        func view(at indexPath: IndexPath) -> View {
            
            switch state(at: indexPath.section) {
                
            case let .fetched(section): return section.view(at: indexPath.item)
                
            case let .prefetching(section): return section.view(at: indexPath.item)
                
            }
            
        }
        
        func state(at section: Int) -> State {
            
            let fetchedCount = fetchedSections?.count ?? 0
            
            let isFetched = (fetchedCount != 0) && (section < fetchedCount)
            
            if isFetched {
                
                guard
                    let section = fetchedSections?.section(at: section)
                else { fatalError("Must have a fetched section.") }
                
                return .fetched(section)
                
            }
            
            if let prefetchingSections = prefetchingSections {
                
                let prefetchingIndex = (section - fetchedCount)
                
                let section = prefetchingSections.section(at: prefetchingIndex)
                
                return .prefetching(section)
                
            }
            
            fatalError("Must have a prefetching section.")
            
        }
        
    }
    
    private final var sections: Sections? {
    
        didSet {
            
            if isViewLoaded { asyncReloadCollectionView() }
            
        }
        
    }

    public final var _prefetchingSessions: U?
    
    public final var storage: S? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            obervation = storage.observe { _ in self.reduceStorage() }
            
            reduceStorage()
            
            if isViewLoaded { loadStorage() }
            
        }
        
    }
    
    public final weak var actionDispatcher: ActionDispatcher?
    
    public final weak var errorHandler: ErrorHandler?
    
    public final var storageReducer: Reducer? {
        
        didSet { reduceStorage() }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if storage?.isLoaded == false { loadStorage() }
        
    }
    
    fileprivate final func reduceStorage() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard
                let self = self,
                let storage = self.storage,
                let reducer = self.storageReducer
            else { return }
            
            let fetchedSections = reducer(storage)
            
            let prefetchingSections = self._prefetchingSessions
            
            self.sections = Sections(
                fetchedSections: fetchedSections,
                prefetchingSections: prefetchingSections
            )
            
        }
        
    }
    
    fileprivate final func loadStorage() {
        
        storage?.load { [weak self] result in
            
            switch result {
                
            case .success: self?.reduceStorage()
                
            case let .failure(error): self?.errorHandler?.catch(error: error)
                
            }
            
        }
        
    }
    
    fileprivate final func asyncReloadCollectionView() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.layout?.invalidateLayout()
            
        }
        
    }
    
}
