//
//  UIProductComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridComponent

public final class UIGridComponent: Component {
    
    private final let collectionComponent: UINewCollectionComponent
    
    private final let columns = 2
    
    private final let margin: CGFloat = 30.0
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.collectionComponent = UINewCollectionComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
    
    }
    
    public final func render() {
        
        collectionComponent.view.backgroundColor = .white
        
        collectionComponent.collectionLayout.minimumLineSpacing = 20.0

        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
            top: margin,
            left: margin,
            bottom: margin,
            right: margin
        )
//
//        let totalMargins = margin * CGFloat(columns + 1)
//
//        let width = (view.bounds.width - totalMargins) / CGFloat(columns)
        
//        let sections = collectionComponent.numberOfSections()
//
//        for section in 0..<sections {
//
//            let items = collectionComponent.numberOfItems(inSection: section)
//
//            for item in 0..<items {
//
//                let indexPath = IndexPath(
//                    item: item,
//                    section: section
//                )
//
//                var itemComponent = collectionComponent.componentForItem(at: indexPath)
//
//                let height = width / (4.0 / 3.0)
//
//                itemComponent?.contentMode = .size(
//                    width: width,
//                    height: height + 63.0 // TODO: remove the magic number.
//                )
//
//            }
//
//        }
        
        collectionComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
}

public extension UIGridComponent {
    
    public typealias NumberOfSectionsHandler = UINewCollectionComponent.NumberOfSectionsHandler
    
    @discardableResult
    public final func setNumberOfSections(_ handler: NumberOfSectionsHandler?) -> UIGridComponent {
        
        collectionComponent.setNumberOfSections(handler)
        
        return self
        
    }
    
    public typealias NumberOfItemsHandler = UINewCollectionComponent.NumberOfItemsHandler
    
    @discardableResult
    public final func setNumberOfItems(_ handler: @escaping NumberOfItemsHandler) -> UIGridComponent {
        
        collectionComponent.setNumberOfItems(handler)
        
        return self
        
    }
    
    public typealias ComponentForItemHandler = UINewCollectionComponent.ComponentForItemHandler
    
    @discardableResult
    public final func setComponentForItem(_ handler: ComponentForItemHandler?) -> UIGridComponent {
        
        collectionComponent.setComponentForItem { [unowned self] indexPath -> Component? in
            
            guard
                var component = handler?(indexPath)
            else { return nil }
        
            let totalMargins = self.margin * CGFloat(self.columns + 1)
            
            let width = (self.view.bounds.width - totalMargins) / CGFloat(self.columns)
            
            let height = width / (4.0 / 3.0)
            
            component.contentMode = .size(
                width: width,
                height: height + 63.0 // TODO: remove the magic number.
            )
            
            return component
            
        }
        
        return self
        
    }
    
//    @discardableResult
//    public final func setItems(
//        _ items: [UIGridItem]
//    )
//    -> UIGridComponent {
//
//        let components: [Component] = items.map { item in
//
//            let component = UIGridItemComponent(
//                contentMode: .size(
//                    width: 0.0,
//                    height: 0.0
//                ) // Prevent the size of an item greater than the collection view, that will raise an exception.
//            )
//
//            component.setItem(item)
//
//            return component
//
//        }
//
//        collectionComponent.itemComponents = AnyCollection(components)
//
//        return self
//
//    }
    
}
