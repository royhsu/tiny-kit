//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

import TinyCore

open class NewCollectionViewController: ViewController {
    
    private final var observations: [Observation] = []
    
    public final let actions = Observable<Action>()
    
    public final let errors = Observable<Error>()
    
    public final var sections: SectionCollection = []
    
    public final var layout: CollectionViewLayout? {
        
        didSet {
            
            if isViewLoaded { prepareLayout() }
            
        }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        prepareLayout()
        
    }
    
    fileprivate final func prepareLayout() {
        
        if let collectionView = layout?.collectionView {
            
            view.subviews.forEach { $0.removeFromSuperview() }
            
            view.wrapSubview(collectionView)
            
        }
        
        layout?.setNumberOfSections { [weak self] _ in
            
            let count = self?.sections.count ?? 0
            
            return count
            
        }
        
        layout?.setNumberOfItems { [weak self] _, section in
            
            let section = self?.sections.section(at: section)
            
            return section?.numberOfViews ?? 0
            
        }
        
        layout?.setViewForItem { [weak self] _, indexPath in
            
            guard
                let self = self
            else { return View() }
            
            let section = self.sections.section(at: indexPath.section)
            
            let view = section.view(at: indexPath.item)
            
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
        
    }
    
}
