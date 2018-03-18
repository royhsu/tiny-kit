//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

/// NOTE: The maximum size of an item is limited to the size of the collection.
public final class UICollectionComponent: Component {
    
    public final let collectionView: UICollectionView
    
    public final let collectionLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewBridge
    
    public final var scrollDirection: UICollectionViewScrollDirection {
        
        get { return collectionLayout.scrollDirection }
        
        set { collectionLayout.scrollDirection = newValue }
        
    }
    
    public typealias ComponentForItemHandler = (IndexPath) -> Component?
    
    private final var componentForItemHandler: ComponentForItemHandler?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
        let frame: CGRect
        
        switch contentMode {
            
        case let .size(width, height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds
            
        }
        
        let collectionLayout = UICollectionViewFlowLayout()
        
        collectionLayout.minimumInteritemSpacing = 0.0
        
        collectionLayout.minimumLineSpacing = 0.0
        
        collectionLayout.headerReferenceSize = .zero
        
        collectionLayout.footerReferenceSize = .zero
        
        collectionLayout.sectionInset = .zero
        
        self.collectionLayout = collectionLayout
        
        let collectionView = UICollectionView(
            frame: frame,
            collectionViewLayout: collectionLayout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView = collectionView
        
        self.bridge = UICollectionViewBridge(collectionView: collectionView)
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in
            
            guard
                let component = self.componentForItemHandler?(indexPath)
            else { return }
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        bridge.sizeForItemHandler = { [unowned self] layout, indexPath in

            var maxWidth = self.collectionView.bounds.width
                - collectionView.contentInset.left
                - collectionView.contentInset.right
                - collectionView.safeAreaInsets.left
                - collectionView.safeAreaInsets.right

            if maxWidth < 0.0 { maxWidth = 0.0 }

            var maxHeight = self.collectionView.bounds.height
                - collectionView.contentInset.top
                - collectionView.contentInset.bottom
                - collectionView.safeAreaInsets.top
                - collectionView.safeAreaInsets.bottom

            if maxHeight < 0.0 { maxHeight = 0.0 }

            guard
                let component = self.componentForItemHandler?(indexPath)
            else { return .zero }

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
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        collectionView.reloadData()
        
        /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
        collectionView.layoutIfNeeded()
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(width, height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic: size = collectionLayout.collectionViewContentSize
            
        }
        
        collectionView.frame.size = size
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionView }
    
    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}

public extension UICollectionComponent {

    public typealias NumberOfSectionsHandler = UICollectionViewBridge.NumberOfSectionsHandler
    
    @discardableResult
    public final func setNumberOfSections(_ handler: NumberOfSectionsHandler?) -> UICollectionComponent {

        bridge.numberOfSectionsHandler = handler

        return self

    }
    
    public final func numberOfSections() -> Int { return collectionView.numberOfSections }
    
    public typealias NumberOfItemsHandler = UICollectionViewBridge.NumberOfItemsHandler
    
    @discardableResult
    public final func setNumberOfItems(_ handler: NumberOfItemsHandler?) -> UICollectionComponent {
        
        bridge.numberOfItemsHandler = handler
        
        return self
        
    }
    
    public final func numberOfItems(inSection section: Int) -> Int { return collectionView.numberOfItems(inSection: section) }

    @discardableResult
    public final func setComponentForItem(_ handler: ComponentForItemHandler?) -> UICollectionComponent {
        
        componentForItemHandler = handler
        
        return self
        
    }
    
    public final func componentForItem(at indexPath: IndexPath) -> Component? { return componentForItemHandler?(indexPath) }
    
    // TODO: maybe it's better to make cell components detect their touching events.
    public typealias DidSelectItemHandler = UICollectionViewBridge.DidSelectItemHandler
    
    @discardableResult
    public final func setDidSelectItem(_ handler: DidSelectItemHandler?) -> Component {
        
        bridge.didSelectItemHandler = handler
        
        return self
        
    }
    
}
