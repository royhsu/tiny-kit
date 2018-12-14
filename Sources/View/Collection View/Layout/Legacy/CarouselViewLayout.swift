//
//  CarouselViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CarouselViewLayout

#if canImport(UIKit)

#warning("TODO: missing test.")
public final class CarouselViewLayout: LegacyCollectionViewLayout {

    private final class Cell: CollectionViewCell, ReusableCell { }

    private final let bridge = CollectionViewBridge()

    public final var _viewController: ViewController? { return bridge }

    public final unowned let collectionView: LegacyCollectionView

    public init(collectionView: LegacyCollectionView) {

        self.collectionView = collectionView

        self.prepare()

    }

    private typealias WidthForItem = (
        _ collectionView: View,
        _ layoutFrame: CGRect,
        _ indexPath: IndexPath
    )
    -> CGFloat

    private final var _widthForItem: WidthForItem?

    public final var interitemSpacing: CGFloat {

        get { return bridge.flowLayout.minimumInteritemSpacing }

        set { bridge.flowLayout.minimumInteritemSpacing = newValue }

    }

    public final var showsScrollIndicator: Bool {

        get { return bridge.collectionView.showsHorizontalScrollIndicator }

        set { bridge.collectionView.showsHorizontalScrollIndicator = newValue }

    }

    #warning("""
    The paging effect is not working what I want.
    Reson:
    1. https://stackoverflow.com/questions/42486960/uicollectionview-horizontal-paging-with-space-between-pages
    2. https://stackoverflow.com/questions/19067459/uiscrollview-paging-enabled-with-content-inset-is-working-strange
    """)
//    public final var isPagingEnabled: Bool {
//
//        get { return _collectionView.isPagingEnabled }
//
//        set { _collectionView.isPagingEnabled = newValue }
//
//    }

    @available(iOS 11.0, *)
    public final var directionalContentInsets: NSDirectionalEdgeInsets {

        get {

            let direction = View.userInterfaceLayoutDirection(for: bridge.collectionView.semanticContentAttribute)

            let insets = bridge.collectionView.contentInset

            switch direction {

            case .leftToRight:

                return .init(
                    top: insets.top,
                    leading: insets.left,
                    bottom: insets.bottom,
                    trailing: insets.right
                )

            case .rightToLeft:

                return .init(
                    top: insets.top,
                    leading: insets.right,
                    bottom: insets.bottom,
                    trailing: insets.left
                )

            }

        }

        set(newInsets) {

            let direction = View.userInterfaceLayoutDirection(for: bridge.collectionView.semanticContentAttribute)

            switch direction {

            case .leftToRight:

                bridge.collectionView.contentInset = .init(
                    top: newInsets.top,
                    left: newInsets.leading,
                    bottom: newInsets.bottom,
                    right: newInsets.trailing
                )

            case .rightToLeft:

                bridge.collectionView.contentInset = .init(
                    top: newInsets.top,
                    left: newInsets.trailing,
                    bottom: newInsets.bottom,
                    right: newInsets.leading
                )

            }

        }

    }

    fileprivate final func prepare() {

        bridge.collectionView.backgroundColor = nil

        bridge.collectionView.dataSource = bridge

        bridge.collectionView.prefetchDataSource = bridge

        bridge.collectionView.delegate = bridge

        bridge.collectionView.registerCell(Cell.self)

        bridge.flowLayout.minimumInteritemSpacing = 0.0

        bridge.flowLayout.minimumLineSpacing = 0.0

        bridge.flowLayout.scrollDirection = .horizontal

        bridge.flowLayout.headerReferenceSize = .zero

        bridge.flowLayout.footerReferenceSize = .zero

        bridge.flowLayout.sectionInset = .zero

        bridge.setNumberOfSections { _ in self.collectionView.sections.count }

        bridge.setNumberOfItems { _, section in

            let section = self.collectionView.sections.section(at: section)

            return section.count

        }

        bridge.setCellForItem { collectionView, indexPath in

            let section = self.collectionView.sections.section(at: indexPath.section)

            let view = section.view(at: indexPath.row)

            let cell = collectionView.dequeueCell(
                Cell.self,
                for: indexPath
            )

            cell.contentView.subviews.forEach { $0.removeFromSuperview() }

            cell.contentView.wrapSubview(view)

            return cell

        }

        bridge.setSizeForItem { [weak self] _, _, indexPath in

            guard
                let self = self
            else { return .zero }

            let layoutFrame = self.bridge.collectionView.layoutFrame

            let width = self._widthForItem?(
                self.bridge.collectionView,
                layoutFrame,
                indexPath
            )

            return CGSize(
                width: width ?? layoutFrame.width,
                height: layoutFrame.height
            )

        }

    }

    public final func invalidate() {

        bridge.flowLayout.invalidateLayout()

        #warning("Not sure if needs to manually call reloadData after invalidated layout.")
        bridge.collectionView.reloadData()

    }

    /// The default width is equal to the width of layout frame.
    /// This make an item fulfills the layout frame of its parent. You must scroll horizontally to see the next item.
    public final func setWidthForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ layoutFrame: CGRect,
            _ indexPath: IndexPath
        )
        -> CGFloat
    ) { _widthForItem = provider }

}

#else

#error("No carousel view layout for the current platform.")

#endif
