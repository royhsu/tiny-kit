//
//  UIProductComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridComponent

//public final class UIGridComponent: Component {
//
//    private final let collectionComponent: UICollectionComponent
//
//    private final let columns = 2
//
//    private final let margin: CGFloat = 30.0
//
//    public init(contentMode: ComponentContentMode = .automatic) {
//
//        self.collectionComponent = UICollectionComponent(contentMode: contentMode)
//
//    }
//
//    // MARK: Component
//
//    public final var contentMode: ComponentContentMode {
//
//        get { return collectionComponent.contentMode }
//
//        set { collectionComponent.contentMode = newValue }
//
//    }
//
//    public final func render() {
//
//        collectionComponent.view.backgroundColor = .white
//
//        collectionComponent.collectionLayout.minimumLineSpacing = 20.0
//
//        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
//            top: margin,
//            left: margin,
//            bottom: margin,
//            right: margin
//        )
//
//        collectionComponent.render()
//
//    }
//
//    // MARK: ViewRenderable
//
//    public final var view: View { return collectionComponent.view }
//
//    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
//
//}
//
//public extension UIGridComponent {
//
//    public typealias NumberOfSectionsHandler = UICollectionComponent.NumberOfSectionsHandler
//
//    @discardableResult
//    public final func setNumberOfSections(_ handler: NumberOfSectionsHandler?) -> UIGridComponent {
//
//        collectionComponent.setNumberOfSections(handler)
//
//        return self
//
//    }
//
//    public typealias NumberOfItemsHandler = UICollectionComponent.NumberOfItemsHandler
//
//    @discardableResult
//    public final func setNumberOfItems(_ handler: @escaping NumberOfItemsHandler) -> UIGridComponent {
//
//        collectionComponent.setNumberOfItems(handler)
//
//        return self
//
//    }
//
//    public typealias ComponentForItemHandler = UICollectionComponent.ComponentForItemHandler
//
//    @discardableResult
//    public final func setComponentForItem(_ handler: ComponentForItemHandler?) -> UIGridComponent {
//
//        collectionComponent.setComponentForItem { [unowned self] indexPath -> Component? in
//
//            guard
//                let component = handler?(indexPath)
//            else { return nil }
//
//            let totalMargins = self.margin * CGFloat(self.columns + 1)
//
//            let width = (self.view.bounds.width - totalMargins) / CGFloat(self.columns)
//
//            let height = width / (4.0 / 3.0)
//
//            component.contentMode = .size(
//                CGSize(
//                    width: width,
//                    height: height + 63.0 // TODO: remove the magic number.
//                )
//            )
//
//            return component
//
//        }
//
//        return self
//
//    }
//
//    public typealias DidSelectItemHandler = UICollectionComponent.DidSelectItemHandler
//
//    @discardableResult
//    public final func setDidSelectItem(_ handler: DidSelectItemHandler?) -> UIGridComponent {
//
//        collectionComponent.setDidSelectItem(handler)
//
//        return self
//
//    }
//
//}
