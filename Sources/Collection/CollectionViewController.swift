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
    C: SectionCollection,
    S: MutableStorage {
    
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
    
    private final var sections: C? {
        
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
    
    public final override func viewDidLoad() {
        
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
            
            self.sections = reducer(storage)
            
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
