//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

public final class UICollectionComponent: CollectionComponent {

    public final let collectionView: UICollectionView

    public final let collectionViewLayout: UICollectionViewLayout

    fileprivate final let bridge: UICollectionViewBridge
    
    fileprivate final let collectionViewWidthConstraint: NSLayoutConstraint
    
    fileprivate final let collectionViewHeightConstraint: NSLayoutConstraint

    public init(
        contentMode: ComponentContentMode,
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
        
        self.numberOfSections = 0
        
        self.prepare()
        
    }
    
    public final func sizeForItem(at indexPath: IndexPath) -> CGSize {
        
        return bridge.sizeForItemProvider(
            collectionViewLayout,
            indexPath
        )
        
    }
    
    public typealias SizeForItemProvider = UICollectionViewBridge.SizeForItemProvider
    
    public final func setSizeForItem(provider: @escaping SizeForItemProvider) {
        
        bridge.sizeForItemProvider = { layout, indexPath in
            
            let size = provider(
                layout,
                indexPath
            )
            
            let component = self.itemComponent(at: indexPath)
            
            component.contentMode = .size(size)
            
            component.render()
            
            return size
            
        }
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        collectionViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        collectionView.backgroundColor = .clear
        
        collectionView.clipsToBounds = false
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case let .automatic(estimatedSize): size = estimatedSize
            
        }
        
        collectionView.frame.size = size

        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(
                    self,
                    indexPath
                )
            else { return }

            cell.contentView.wrapSubview(component.view)

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
        
        guard
            let provider = itemComponentProvider
        else { fatalError("Please make sure to set the provider with setItemComponent(provider:) firstly.") }
        
        return provider(
            self,
            indexPath
        )
        
    }
    
    private final var itemComponentProvider: ItemComponentProvider?
    
    public final func setItemComponent(provider: @escaping ItemComponentProvider) { itemComponentProvider = provider }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {
        
        let collectionViewConstraints = [
            collectionViewWidthConstraint,
            collectionViewHeightConstraint
        ]
        
        NSLayoutConstraint.deactivate(collectionViewConstraints)
        
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
