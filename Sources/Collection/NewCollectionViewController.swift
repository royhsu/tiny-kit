//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

open class NewCollectionViewController: ViewController {
    
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
                let section = self?.sections.section(at: indexPath.section)
                else { return View() }
            
            return section.view(at: indexPath.item)
            
        }
        
    }
    
}
