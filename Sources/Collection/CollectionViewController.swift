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

open class CollectionViewController<S>: ViewController, Actionable, Failable
where S: Storage {
    
    public typealias Reducer = (S) -> SectionCollection
    
    private final var observations: [Observation] = []
    
    public final let actions = Observable<Action>()
    
    public final let errors = Observable<Error>()
    
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
                    let self = self,
                    let view = self.sections?.view(at: indexPath)
                else { return View() }
                
                if let actionable = view as? Actionable {
                    
                    let observation = actionable.actions.observe { change in
                        
                        self.actions.value = change.currentValue
                        
                    }
                    
                    self.observations.append(observation)
                    
                }
                
                if let errorHandler = view as? ErrorHandler {
                    
                    let observation = self.errors.observe { change in
                        
                        guard
                            let error = change.currentValue
                        else { return }
                        
                        errorHandler.catch(error: error)
                        
                    }
                    
                    self.observations.append(observation)
                    
                }
    
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
                    
                    #warning("Why does here need to reduce the storage?")
//                    self.reduceStorage()
                    
                }
                
            }
            
//            layout?.invalidate()
            
        }
        
    }
    
    private struct Sections {
        
        enum State {
            
            case fetched(SectionCollection.Section)
            
            case prefetching(SectionCollection.Section)
            
        }
        
        let fetchedSections: SectionCollection?
        
        let prefetchingSections: SectionCollection?
        
        init(
            fetchedSections: SectionCollection?,
            prefetchingSections: SectionCollection?
        ) {
            
            if let fetchedSections = fetchedSections {
                
                self.fetchedSections = fetchedSections
                
            }
            else { self.fetchedSections = nil }
            
            if
                let prefetchingSections = prefetchingSections,
                !prefetchingSections.isEmpty
            {
    
                self.prefetchingSections = prefetchingSections
                
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
                
            case let .fetched(section): return section.numberOfViews
                
            case let .prefetching(section): return section.numberOfViews
                
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
            
//            if isViewLoaded { asyncReloadCollectionView() }
            
        }
        
    }

    public final var _prefetchingSessions: SectionCollection?
    
    #warning("TODO: should provide an opt-in way to reduce storage while changes happen.")
    #warning("TODO: is a good idea to pack storage and reducer together? may be not.")
    public final var storage: S? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            observations = []
            
            observations.append(
                storage.observe { _ in self.reduceStorage() }
            )
            
        }
        
    }
    
    public final var storageReducer: Reducer? {
        
        didSet { reduceStorage() }
        
    }
    
//    open override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        if storage?.isLoaded == false { loadStorage() }
//
//    }
    
    fileprivate final func reduceStorage() {
       
        if storage?.isLoaded == false { return }
        
//        #warning("Use sync to ensure reduce happen immediately before the next reload.")
        DispatchQueue.main.async { [weak self] in
        
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
    
//    fileprivate final func loadStorage() {
//
//        guard
//            let storage = storage
//        else { return }
//
//        observations = []
//
//        observations.append(
//            storage.observe { _ in
//
//                #warning("This will resign first responder.")
//                self.reduceStorage()
//
//            }
//        )
//
//        storage.load { [weak self] result in
//
//            switch result {
//
//            case .success: self?.reduceStorage()
//
//            case let .failure(error): self?.errors.value = error
//
//            }
//
//        }
//
//    }
    
//    fileprivate final func asyncReloadCollectionView() {
//
//        DispatchQueue.main.async { [weak self] in
//
//            self?.layout?.invalidate()
//
//        }
//
//    }
    
}
