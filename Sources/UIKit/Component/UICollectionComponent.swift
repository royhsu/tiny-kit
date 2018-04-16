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

    internal final let collectionViewLayout: UICollectionViewLayout

    fileprivate final let bridge: UICollectionViewBridge
    
    fileprivate final let collectionViewHeightConstraint: NSLayoutConstraint

    public init(
        contentMode: ComponentContentMode = .automatic,
        layout: UICollectionViewLayout
    ) {

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
            
        case let .automatic2(width): fatalError()

        }

        self.collectionViewLayout = layout

        let collectionView = UICollectionView(
            frame: frame,
            collectionViewLayout: collectionViewLayout
        )

        self.collectionView = collectionView

        self.bridge = UICollectionViewBridge(collectionView: collectionView)
        
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
    
    public final func setSizeForItem(provider: @escaping SizeForItemProvider) { bridge.sizeForItemProvider = provider }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {

        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return }
            
            component.render()

            cell.contentView.wrapSubview(component.view)

        }
        
        collectionView.backgroundColor = .clear
        
        collectionView.clipsToBounds = false
        
        collectionViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        NSLayoutConstraint.activate(
            [ collectionViewHeightConstraint ]
        )
        
    }

    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return bridge.numberOfSections }
        
        set { bridge.numberOfSections = newValue }
        
    }
    
    public final func numberOfItemComponents(inSection section: Int) -> Int { return bridge.numberOfItemsProvider(section) }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { bridge.numberOfItemsProvider = provider }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component {
        
        guard
            let provider = itemComponentProvider
        else { fatalError("Please make sure to set the provider with setItemComponent(provider:) firstly.") }
        
        return provider(indexPath)
        
    }
    
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

        case .automatic: size = collectionViewLayout.collectionViewContentSize

        case let .automatic2(width): fatalError()
            
        }

        collectionView.frame.size = size
        
        collectionViewHeightConstraint.constant = size.height

    }

    // MARK: ViewRenderable

    public final var view: View { return collectionView }

    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}
