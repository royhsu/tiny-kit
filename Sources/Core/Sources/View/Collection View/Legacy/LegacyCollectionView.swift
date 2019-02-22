//
//  LegacyCollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacyCollectionView

public final class LegacyCollectionView: View {

    public final var alwaysBounceVertical: Bool = true {

        didSet { alwaysBounceVerticalDidChange?(alwaysBounceVertical) }

    }

    public final var alwaysBounceVerticalDidChange:  ( (Bool) -> Void )?

    public final var sections: LegacySectionCollection = []

    public final func applyLayout(_ layoutType: LegacyCollectionViewLayout.Type) {

        layout = layoutType.init(collectionView: self)

        #warning("Not sure if this invalidating is required.")
//        layout?.invalidate()

    }

    public final var layoutDidChange: (
        _ oldLayout: LegacyCollectionViewLayout?,
        _ newLayout: LegacyCollectionViewLayout?
    )
    -> Void = { _, _ in }

    public private(set) final var layout: LegacyCollectionViewLayout? {

        didSet(oldLayout) {

            let newLayout = layout

            layoutDidChange(
                oldLayout,
                newLayout
            )

        }

    }

}
