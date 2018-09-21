//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

import UIKit
import TinyCore

open class CollectionViewController<S, C>: ViewController
where
    S: MutableStorage,
    C: SectionCollection {
    
    public typealias Reducer = (S) -> C
    
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
            
            layout?.invalidateLayout()
            
        }
        
    }
    
    private struct Sections<Section>: SectionCollection {
        
        typealias Section = C.Section
        
        let fetchedSections: C?
        
        let prefetchingSections: C?
        
        init(
            fetchedSections: C?,
            prefetchingSections: C?
        ) {
            
            self.fetchedSections = fetchedSections
            
            self.prefetchingSections = prefetchingSections
            
        }
        
        var count: Int {
            
            let fetchedCount = fetchedSections?.count ?? 0
            
            let prefetchingCount = prefetchingSections?.count ?? 0
            
            return fetchedCount + prefetchingCount
            
        }
        
        func section(at index: Int) -> Section {
            
            let fetchedCount = fetchedSections?.count ?? 0
            
            if let prefetchingSections = prefetchingSections {
                
                let isPrefetching = (index >= fetchedCount)
                
                if isPrefetching { return prefetchingSections.section(at: index) }
                
            }

            guard
                let fetchedSection = fetchedSections?.section(at: index)
            else { fatalError("Must have a fetched section.") }
            
            return fetchedSection
            
        }
        
    }
    
    private final var sections: Sections<C.Section>? {
    
        didSet {
            
            if isViewLoaded { asyncReloadCollectionView() }
            
        }
        
    }

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
        
        DispatchQueue.main.async { [weak self] in
            
            guard
                let self = self,
                let storage = self.storage,
                let reducer = self.reducer
            else { return }
            
            let fetchedSections = reducer(storage)
            
            #warning("TODO: prefetching sections data source.")
            let prefetchingSections: C? = nil
            
            #warning("TODO: sections generator.")
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
    
    private final var subscriptions: [ObservableSubscription] = []
    
}

public protocol PrefetchableSectionCollection: SectionCollection {
    
//    var numberOfPrefetchingSections: Int { get }
//
//    func setNumberOfPrefetchingSections(
//        provider: @escaping (View) -> Int
//    )
//
//    func setNumberOfPrefetchingItems(
//        provider: @escaping (View, _ section: Int) -> Int
//    )
//
//    func setViewForPrefetchingItem(
//        provider: @escaping (View, IndexPath) -> View
//    )
    
}
