//
//  UICollectionViewUICarouselComponentBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionViewUICarouselComponentBridge

internal final class UICollectionViewUICarouselComponentBridge: NSObject {
    
    internal final var itemComponents: ListItemComponents = AnyCollection(
        [Component]()
    )
    
    internal final let collectionView: UICollectionView
    
    internal init(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        
        super.init()
        
        setUpCollectionView(collectionView)
        
    }
    
    fileprivate final func setUpCollectionView(_ collectionView: UICollectionView) {
        
        collectionView.registerCell(UICollectionViewCell.self)
        
        collectionView.dataSource = self
        
    }
    
}

// MARK: - UICollectionViewDataSource

extension UICollectionViewUICarouselComponentBridge: UICollectionViewDataSource {
    
    internal final func numberOfSections(in collectionView: UICollectionView) -> Int { return itemComponents.numberOfSections() }
    
    internal final func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    )
    -> Int { return itemComponents.numberOfItemsAtSection(section) }
    
    internal final func collectionView(
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
        
        let component = itemComponents.componentForItem(at: indexPath)
        
        component.render()
        
        cell.contentView.render(with: component)
        
        return cell
        
    }
    
}
