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

    public init(collectionView: UICollectionView) {

        self.numberOfSections = 0
        
        self.numberOfItemsProvider = { _ in 0 }
        
        self.sizeForItemProvider = { _, _ in .zero }
        
        self.collectionView = collectionView

        super.init()

        setUpCollectionView(collectionView)

    }
    
    // MARK: Set Up

    fileprivate final func setUpCollectionView(_ collectionView: UICollectionView) {

        collectionView.registerCell(UICollectionViewCell.self)

        collectionView.dataSource = self

        collectionView.delegate = self

    }

    public final var numberOfSections: Int

    public typealias NumberOfItemsProvider = (_ section: Int) -> Int

    public final var numberOfItemsProvider: NumberOfItemsProvider

    public typealias ConfigureCellHandler = (UICollectionViewCell, IndexPath) -> Void

    public final var configureCellHandler: ConfigureCellHandler?

    public typealias SizeForItemProvider = (UICollectionViewLayout, IndexPath) -> CGSize

    public final var sizeForItemProvider: SizeForItemProvider

}

// MARK: - UICollectionViewDataSource

extension UICollectionViewBridge: UICollectionViewDataSource {

    public final func numberOfSections(in collectionView: UICollectionView) -> Int { return numberOfSections }

    public final func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    )
    -> Int { return numberOfItemsProvider(section) }

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
        else { fatalError("CANNOT dequeue a cell with type UICollectionViewCell.") }

        // TODO: there are no visual hints for debugging a cell because there the background color is nil.
        // should find a way to improve the UI debugging process.

        // TODO: should find a better strategy to remove previously added views.
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        configureCellHandler?(
            cell,
            indexPath
        )

        return cell

    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension UICollectionViewBridge: UICollectionViewDelegateFlowLayout {

    public final func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    )
    -> CGSize {
        
        return sizeForItemProvider(
            collectionViewLayout,
            indexPath
        )
        
    }

}
