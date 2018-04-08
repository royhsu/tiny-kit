//
//  UICollectionViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionViewBridge

public final class UICollectionViewBridge: NSObject {
    
    private final unowned let collectionView: UICollectionView
    
    internal init(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        
        super.init()
        
        setUpCollectionView(collectionView)
        
    }
    
    fileprivate final func setUpCollectionView(_ collectionView: UICollectionView) {
        
        collectionView.registerCell(UICollectionViewCell.self)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
    }
    
    public typealias NumberOfSectionsHandler = () -> Int
    
    public final var numberOfSectionsHandler: NumberOfSectionsHandler?
    
    public typealias NumberOfItemsHandler = (_ section: Int) -> Int
    
    public final var numberOfItemsHandler: NumberOfItemsHandler?
    
    public typealias ConfigureCellHandler = (UICollectionViewCell, IndexPath) -> ()
    
    public final var configureCellHandler: ConfigureCellHandler?
    
    public typealias SizeForItemHandler = (UICollectionViewLayout, IndexPath) -> CGSize
    
    public final var sizeForItemHandler: SizeForItemHandler?
    
    public typealias DidSelectItemHandler = (IndexPath) -> Void
    
    public final var didSelectItemHandler: DidSelectItemHandler?
    
}

// MARK: - UICollectionViewDataSource

extension UICollectionViewBridge: UICollectionViewDataSource {
    
    public final func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        let sections = numberOfSectionsHandler?()
            
        return sections ?? 0
        
    }
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    )
    -> Int {
        
        let items = numberOfItemsHandler?(section)
        
        return items ?? 0
        
    }
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    )
    -> UICollectionViewCell {

        guard
            let cell = collectionView.dequeueReusableCell(
                UICollectionViewCell.self,
                for: indexPath
            )
        else { fatalError("Cannot dequeue a cell from type UICollectionViewCell.") }
        
        // TODO: there are no visual hints for debugging a cell because there the background color is nil.
        // should find a way to improve the UI debugging process.
        
        // TODO: should find a better strategy to remove previously added views.
        cell.contentView.subviews.forEach {
            
            $0.removeFromSuperview()
            
        }
        
        configureCellHandler?(
            cell,
            indexPath
        )
        
        return cell

    }
    
}

// MARK: - UICollectionViewDelegate

extension UICollectionViewBridge: UICollectionViewDelegate {
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) { didSelectItemHandler?(indexPath) }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UICollectionViewBridge: UICollectionViewDelegateFlowLayout {
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    )
    -> CGSize {

        let size = sizeForItemHandler?(
            collectionViewLayout,
            indexPath
        )
        
        return size ?? .zero

    }
    
}
