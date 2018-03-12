//
//  UIProductComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridComponent

public final class UIGridComponent: Component {
    
    private final let collectionComponent: UICollectionComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.collectionComponent = UICollectionComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
    
    }
    
    public final func render() {
        
        let columns = 2
        
        let margin: CGFloat = 30.0
        
        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
            top: 0.0,
            left: margin,
            bottom: 0.0,
            right: margin
        )
        
        let totalMargins = margin * CGFloat(columns + 1)
        
        let width = (view.bounds.width - totalMargins) / CGFloat(columns)
        
        let sections = collectionComponent.itemComponents.numberOfSections()
        
        for section in 0..<sections {
            
            let items = collectionComponent.itemComponents.numberOfItems(inSection: section)
            
            for item in 0..<items {
                
                let indexPath = IndexPath(
                    item: item,
                    section: section
                )
                
                var itemComponent = collectionComponent.itemComponents.componentForItem(at: indexPath)
                
                let height = width / (4.0 / 3.0)
                
                itemComponent.contentMode = .size(
                    width: width,
                    height: height + 63.0 // TODO: remove the magic number.
                )
                
            }
            
        }
        
        collectionComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
}

public extension UIGridComponent {
    
    @discardableResult
    public final func setItems(
        _ items: [UIGridItem]
    )
    -> UIGridComponent {
            
        let components: [Component] = items.map { item in
            
            let component = UIGridItemComponent(
                contentMode: .size(
                    width: 0.0,
                    height: 0.0
                ) // Prevent the size of an item greater than the collection view, that will raise an exception.
            )
            
            component.setItem(item)
            
            return component
            
        }
        
        collectionComponent.itemComponents = AnyCollection(components)
        
        return self
        
    }
    
}
