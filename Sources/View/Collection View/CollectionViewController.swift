//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

open class CollectionViewController: ViewController, CollectionViewDataSource {
    
    open var sections: SectionCollection = []
    
    public final var collectionView: (View & CollectionView)? { return collectionViewLayout?.collectionView }
    
    public final var collectionViewLayout: CollectionViewLayout? {
        
        willSet {
            
            guard
                isViewLoaded,
                let oldLayout = collectionViewLayout
            else { return }
            
            oldLayout.collectionView.removeFromSuperview()
            
        }
        
        didSet {
            
            guard
                isViewLoaded,
                let newLayout = collectionViewLayout
            else { return }
            
            view.wrapSubview(newLayout.collectionView)
            
            newLayout.collectionView.dataSource = self
            
        }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let initialLayout = collectionViewLayout {
            
            view.wrapSubview(initialLayout.collectionView)
            
            initialLayout.collectionView.dataSource = self
            
        }
        else {
            
            #warning("Debug-only warning.")
            print("[WARNING]: The collection view controller has no layout to display sections.")
            
        }
        
    }
    
}
