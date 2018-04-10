//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

/// NOTE: The maximum size of an item is limited to the size of the collection.
public final class UICollectionComponent: CollectionComponent {

    // TODO: mark as internal.
    public final let collectionView: UICollectionView

    // TODO: mark as internal.
    public final let collectionLayout: UICollectionViewFlowLayout

    fileprivate final let bridge: UICollectionViewBridge
    
    fileprivate final let collectionViewHeightConstraint: NSLayoutConstraint

    public init(contentMode: ComponentContentMode = .automatic) {

        self.contentMode = contentMode

        let frame: CGRect

        switch contentMode {

        case let .size(size):

            frame = CGRect(
                origin: .zero,
                size: size
            )

        case .automatic:

            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds

        }

        // TODO: inject from outside.
        let collectionLayout = UICollectionViewFlowLayout()

//        collectionLayout.minimumInteritemSpacing = 10.0
//
//        collectionLayout.minimumLineSpacing = 10.0
        
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

        self.collectionView = collectionView

        self.bridge = UICollectionViewBridge(collectionView: collectionView)
        
        self.collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionView.bounds.height)
        
        self.numberOfSections = 0
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {

        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return }

            cell.contentView.wrapSubview(component.view)
            
            component.render()

        }

//        bridge.sizeForItemProvider = { [unowned self] layout, indexPath in
//
//            var maxWidth = self.collectionView.bounds.width
//                - self.collectionView.contentInset.left
//                - self.collectionView.contentInset.right
//                - self.collectionView.safeAreaInsets.left
//                - self.collectionView.safeAreaInsets.right
//
//            if maxWidth < 0.0 { maxWidth = 0.0 }
//
//            var maxHeight = self.collectionView.bounds.height
//                - self.collectionView.contentInset.top
//                - self.collectionView.contentInset.bottom
//                - self.collectionView.safeAreaInsets.top
//                - self.collectionView.safeAreaInsets.bottom
//
//            if maxHeight < 0.0 { maxHeight = 0.0 }
//
//            guard
//                let component = self.componentForItemHandler?(indexPath)
//            else { return .zero }
//
//            component.render()
//
//            let width = (component.preferredContentSize.width < maxWidth)
//                ? component.preferredContentSize.width
//                : maxWidth
//
//            let height = (component.preferredContentSize.height < maxHeight)
//                ? component.preferredContentSize.height
//                : maxHeight
//
//            // TODO: make warnings for item size that's not in a valid range.
//
//            return CGSize(
//                width: width,
//                height: height
//            )
//
//        }

    }

    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return bridge.numberOfSections }
        
        set { bridge.numberOfSections = newValue }
        
    }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { bridge.numberOfItemsProvider = provider }
    
    private final var itemComponentProvider: ItemComponentProvider?
    
    public final func setItemComponent(provider: @escaping ItemComponentProvider) { itemComponentProvider = provider }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        collectionView.reloadData()

        /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
        collectionView.layoutIfNeeded()

        let size: CGSize

        switch contentMode {

        case let .size(value): size = value

        case .automatic: size = collectionLayout.collectionViewContentSize

        }

        collectionView.frame.size = size

    }

    // MARK: ViewRenderable

    public final var view: View { return collectionView }

    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}

public extension UICollectionComponent {
    
    public final var scrollDirection: UICollectionViewScrollDirection {
        
        get { return collectionLayout.scrollDirection }
        
        set { collectionLayout.scrollDirection = newValue }
        
    }
    
    public typealias SizeForItemProvider = UICollectionViewBridge.SizeForItemProvider
    
    public final var sizeForItemProvider: SizeForItemProvider {
        
        get { return bridge.sizeForItemProvider }
        
        set { bridge.sizeForItemProvider = newValue }
        
    }

}
