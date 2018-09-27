//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

open class CollectionViewController: ViewController {
    
    private final var _observations: [Observation] = []
    
    private final var _actionDispatcher: Optional< (Action) -> Void >
    
    private final var _errorHandler: Optional< (Error) -> Void >
    
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
    
    public final func setAction(
        _ dispatcher: @escaping (Action) -> Void
    ) { _actionDispatcher = dispatcher }
    
    public final func setError(
        _ handler: @escaping (Error) -> Void
    ) { _errorHandler = handler }
    
    fileprivate final func prepareLayout() {
        
        if let collectionView = layout?.collectionView {
            
            view.subviews.forEach { $0.removeFromSuperview() }
            
            view.wrapSubview(collectionView)
            
        }
        
        layout?.setNumberOfSections { [weak self] _ in
            
            self?._observations = []
            
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
                
                self._observations.append(
                    actionable.actions.observe { [weak self] change in
                        
                        guard
                            let action = change.currentValue
                        else { return }
                        
                        self?._actionDispatcher?(action)
                        
                    }
                )
                
            }
            
            if let failable = view as? Failable {
                
                self._observations.append(
                    failable.errors.observe { [weak self] change in
                        
                        guard
                            let error = change.currentValue
                        else { return }
                        
                        self?._errorHandler?(error)
                        
                    }
                )
                
            }
            
            return view
            
        }
        
    }
    
}
