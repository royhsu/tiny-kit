//
//  CollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionView

public protocol CollectionViewDataSource: AnyObject {
    
    var sections: NewSectionCollection { get }
    
}

public protocol NewCollectionView: AnyObject {
    
    var dataSource: CollectionViewDataSource? { get set }
    
    func reloadData()
    
}

public final class CollectionView: View {

    public final var alwaysBounceVertical: Bool = true {

        didSet { alwaysBounceVerticalDidChange?(alwaysBounceVertical) }

    }

    public final var alwaysBounceVerticalDidChange:  ( (Bool) -> Void )?

    public final var sections: SectionCollection = []

    public final func applyLayout(_ layoutType: CollectionViewLayout.Type) {

        layout = layoutType.init(collectionView: self)

        #warning("Not sure if this invalidating is required.")
//        layout?.invalidate()

    }

    public final var layoutDidChange: (
        _ oldLayout: CollectionViewLayout?,
        _ newLayout: CollectionViewLayout?
    )
    -> Void = { _, _ in }

    public private(set) final var layout: CollectionViewLayout? {

        didSet(oldLayout) {

            let newLayout = layout

            layoutDidChange(
                oldLayout,
                newLayout
            )

        }

    }

}
