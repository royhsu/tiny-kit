//
//  UICollectionViewCollectionComponentBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionViewCollectionComponentBridge

internal final class UICollectionViewCollectionComponentBridge: NSObject {
    
    internal final var componentGroup: ComponentGroup = AnyCollection(
        [Component]()
    )
    
    internal unowned final let collectionView: UICollectionView
    
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
    
}

// MARK: - UICollectionViewDataSource

extension UICollectionViewCollectionComponentBridge: UICollectionViewDataSource {
    
    internal final func numberOfSections(in collectionView: UICollectionView) -> Int { return componentGroup.numberOfSections() }
    
    internal final func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    )
    -> Int { return componentGroup.numberOfItems(inSection: section) }
    
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
        
        let component = componentGroup.componentForItem(at: indexPath)
        
        cell.contentView.render(with: component)
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UICollectionViewCollectionComponentBridge: UICollectionViewDelegateFlowLayout {
    
    internal final func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    )
    -> CGSize {
        
        var maxWidth = collectionView.bounds.width
            - collectionView.contentInset.left
            - collectionView.contentInset.right
            - collectionView.safeAreaInsets.left
            - collectionView.safeAreaInsets.right

        if maxWidth < 0.0 { maxWidth = 0.0 }

        var maxHeight = collectionView.bounds.height
            - collectionView.contentInset.top
            - collectionView.contentInset.bottom
            - collectionView.safeAreaInsets.top
            - collectionView.safeAreaInsets.bottom

        if maxHeight < 0.0 { maxHeight = 0.0 }

        let component = componentGroup.componentForItem(at: indexPath)

        component.render()

        let width = (component.preferredContentSize.width < maxWidth)
            ? component.preferredContentSize.width
            : maxWidth

        let height = (component.preferredContentSize.height < maxHeight)
            ? component.preferredContentSize.height
            : maxHeight

        // TODO: make warnings for item size that's not in a valid range.
        
        return CGSize(
            width: width,
            height: height
        )
        
    }
    
}
