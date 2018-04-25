//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

/// Grouping a collection of item components.
///
/// The collection component needs a dedicated layout to render the item components.
/// The collection component overrides the content mode for each item component to fit the size calculated by the layout during the rendering.
///
/// Please make sure to give a non-zero size for the list to properly render its content.
public final class UICollectionComponent: CollectionComponent {

    public final let collectionView: UICollectionView

    public final let collectionViewLayout: UICollectionViewLayout

    fileprivate final let bridge: UICollectionViewBridge
    
    fileprivate final let collectionViewWidthConstraint: NSLayoutConstraint
    
    fileprivate final let collectionViewHeightConstraint: NSLayoutConstraint

    // DO NOT get an item component from the map directly, please use itemComponent(at:) instead.
    internal final var itemComponentMap: [IndexPath: Component]
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        layout: UICollectionViewLayout
    ) {

        self.contentMode = contentMode

        self.collectionViewLayout = layout

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )

        self.collectionView = collectionView

        self.bridge = UICollectionViewBridge(collectionView: collectionView)
        
        self.collectionViewWidthConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionView.bounds.width)
        
        self.collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionView.bounds.height)
        
        self.itemComponentMap = [:]
        
        self.prepare()
        
    }
    
    public final func sizeForItem(at indexPath: IndexPath) -> CGSize {
        
        return bridge.sizeForItemProvider(
            collectionViewLayout,
            indexPath
        )
        
    }
    
    public typealias SizeForItemProvider = (
        _ component: Component,
        _ layout: UICollectionViewLayout,
        _ indexPath: IndexPath
    )
    -> CGSize
    
    public final func setSizeForItem(provider: @escaping SizeForItemProvider) {
        
        bridge.sizeForItemProvider = { layout, indexPath in
            
            return provider(
                self,
                layout,
                indexPath
            )
            
        }
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        collectionViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        collectionView.backgroundColor = .clear
        
        collectionView.clipsToBounds = false
        
        collectionView.frame.size = contentMode.initialSize

        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            let component = self.itemComponent(at: indexPath)
            
            let size = self.sizeForItem(at: indexPath)

            cell.contentView.frame.size = size
            
            cell.frame.size = cell.contentView.frame.size
            
            cell.contentView.wrapSubview(component.view)
            
            component.render()

        }
        
    }

    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return bridge.numberOfSections }
        
        set { bridge.numberOfSections = newValue }
        
    }
    
    public final func numberOfItemComponents(inSection section: Int) -> Int { return bridge.numberOfItemsProvider(section) }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) {
        
        bridge.numberOfItemsProvider = { [unowned self] section in
        
            return provider(
                self,
                section
            )
        
        }
        
    }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component {
        
        if let provider = itemComponentMap[indexPath] { return provider }
        else {
            
            guard
                let provider = itemComponentProvider
                else { fatalError("Please make sure to set the provider with setItemComponent(provider:) firstly.") }
            
            let itemComponent = provider(
                self,
                indexPath
            )
            
            itemComponentMap[indexPath] = itemComponent
            
            return itemComponent
            
        }
        
    }
    
    private final var itemComponentProvider: ItemComponentProvider?
    
    public final func setItemComponent(provider: @escaping ItemComponentProvider) { itemComponentProvider = provider }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {
        
        itemComponentMap = [:]
        
        renderLayout()
        
    }
    
    fileprivate final func renderLayout() {
        
        let collectionViewConstraints = [
            collectionViewWidthConstraint,
            collectionViewHeightConstraint
        ]
        
        NSLayoutConstraint.deactivate(collectionViewConstraints)
        
        collectionViewLayout.invalidateLayout()
        
        switch contentMode {
            
        case let .size(size):
            
            collectionView.frame.size = size
            
            collectionView.reloadData()
            
        case let .automatic(estimatedSize):
            
            collectionView.frame.size = estimatedSize
            
            collectionView.reloadData()
            
            /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
            collectionView.layoutIfNeeded()
            
            collectionView.frame.size.height = collectionViewLayout.collectionViewContentSize.height
            
        }
        
        collectionViewWidthConstraint.constant = collectionView.frame.width
        
        collectionViewHeightConstraint.constant = collectionView.frame.height
        
        NSLayoutConstraint.activate(collectionViewConstraints)
        
    }

    // MARK: ViewRenderable

    public final var view: View { return collectionView }

    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}
