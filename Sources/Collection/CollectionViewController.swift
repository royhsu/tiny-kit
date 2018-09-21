//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

import UIKit
import TinyStorage
import TinyCore

open class CollectionViewController<S, C>: ViewController
where
    S: TinyStorage.Storage,
    C: SectionCollection {
    
    public typealias Reducer = (S) -> C
    
    private final var subscriptions: [ObservableSubscription] = []
    
    public final var layout: CollectionViewLayout? {
        
        didSet {
            
            if let collectionView = layout?.collectionView {
                
                view.subviews.forEach { $0.removeFromSuperview() }
                
                view.wrapSubview(collectionView)
                
            }
            
            layout?.setNumberOfSections { [weak self] _ in self?.sections?.count ?? 0 }
    
            layout?.setNumberOfItems { [weak self] _, section in
    
                let section = self?.sections?.section(at: section)
    
                return section?.numberOfElements ?? 0
    
            }
    
            layout?.setViewForItem { [weak self] _, indexPath in
    
                guard
                    let section = self?.sections?.section(at: indexPath.section)
                else { return View() }
    
                return section.view(at: indexPath.item)
    
            }
            
            if let prefetchableLayout = layout as? PrefetchableCollectViewLayout {
                
                prefetchableLayout.setPrefetchingForItems { [weak self] _, indexPaths in
                    
                    #warning("FIXME: The loading more won't trigger while the displayed cells were too few.")
                    guard
                        let self = self,
                        let lastIndexPath = indexPaths.min(),
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
    
    private struct Sections<Section>: SectionCollection where Section == C.Section {
        
        enum State {
            
            case fetched(Section)
            
            case prefetching(Section)
            
            var section: Section {
                
                switch self {
                    
                case let .fetched(section): return section
                   
                case let .prefetching(section): return section
                    
                }
                
            }
            
        }
        
        let fetchedSections: AnySectionCollection<Section>?
        
        let prefetchingSections: AnySectionCollection<Section>?
        
        init<T, U>(
            fetchedSections: T?,
            prefetchingSections: U?
        )
        where
            T: SectionCollection,
            T.Section == Section,
            U: SectionCollection,
            U.Section == Section
        {
            
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
        
        func section(at index: Int) -> Section { return state(at: index).section }
        
        func state(at index: Int) -> State {
            
            let fetchedCount = fetchedSections?.count ?? 0
            
            let isFetched = (fetchedCount != 0) && (index < fetchedCount)
            
            if isFetched {
                
                guard
                    let section = fetchedSections?.section(at: index)
                else { fatalError("Must have a fetched section.") }
                
                return .fetched(section)
                
            }
            
            if let prefetchingSections = prefetchingSections {
                
                let prefetchingIndex = (index - fetchedCount)
                
                let section = prefetchingSections.section(at: prefetchingIndex)
                
                return .prefetching(section)
                
            }
            
            fatalError("Must have a prefetching section.")
            
        }
        
    }
    
    private final var sections: Sections<C.Section>? {
    
        didSet {
            
            if isViewLoaded { asyncReloadCollectionView() }
            
        }
        
    }

    public final var _prefetchingStorage: S?
    
    public final var storage: S? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            let subscription = storage.changes.subscribe { _ in self.reduceStorage() }
            
            subscriptions = [ subscription ]
            
            reduceStorage()
            
            if isViewLoaded { loadStorage() }
            
        }
        
    }
    
    public final var reducer: Reducer? {
        
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
                let reducer = self.reducer
            else { return }
            
            let fetchedSections = reducer(storage)
            
            let prefetchingSections: C?
            
            if let prefetchingStorage = self._prefetchingStorage {
                
                prefetchingSections = reducer(prefetchingStorage)
                
            }
            else { prefetchingSections = nil }
            
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
                
            case let .failure(error):
                
                #warning("delegate the error.")
                print("\(error)")
                
            }
            
        }
        
    }
    
    fileprivate final func asyncReloadCollectionView() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.layout?.invalidateLayout()
            
        }
        
    }
    
}
