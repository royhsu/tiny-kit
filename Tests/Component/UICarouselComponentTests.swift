//
//  UICarouselComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StubItemComponents

internal class StubItemComponents: ListItemComponents {
    
    private final let _numberOfSections: () -> Int
    
    private final let _numberOfItemsAtSection: (_ section: Int) -> Int
    
    private final let _componentAtItem: (_ indexPath: IndexPath) -> Component
    
    public init(
        numberOfSections: @escaping () -> Int,
        numberOfItemsAtSection: @escaping (_ section: Int) -> Int,
        componentAtItem: @escaping (_ indexPath: IndexPath) -> Component
    ) {
        
        self._numberOfSections = numberOfSections
        
        self._numberOfItemsAtSection = numberOfItemsAtSection
        
        self._componentAtItem = componentAtItem
        
    }
    
    internal final func numberOfSections() -> Int { return _numberOfSections() }
    
    internal final func numberOfItemsAtSection(_ section: Int) -> Int { return _numberOfItemsAtSection(section) }
    
    internal final func componentForItem(at indexPath: IndexPath) -> Component { return _componentAtItem(indexPath) }
    
}

// MARK: - UICarouselComponentTests

import XCTest

@testable import TinyKit

internal final class UICarouselComponentTests: XCTestCase {
    
    internal final func testRenderCarouselComponent() {
        
        let carouselComponent = UICarouselComponent()
        
        let components: [Component] = [
            UIItemComponent(
                contentMode: .size(
                    width: 100.0,
                    height: 100.0
                ),
                itemView: RectangleView()
            ),
            UIItemComponent(
                contentMode: .size(
                    width: 200.0,
                    height: 200.0
                ),
                itemView: RectangleView()
            )
        ]
        
        carouselComponent.itemComponents = StubItemComponents(
            numberOfSections: { return components.count },
            numberOfItemsAtSection: { section in return 1 },
            componentAtItem: { indexPath in components[indexPath.section] }
        )
        
        carouselComponent.render()
        
        let collectionView = carouselComponent.collectionView
        
        XCTAssertEqual(
            collectionView.numberOfSections,
            components.count
        )
        
        for section in 0..<components.count {
            
            XCTAssertEqual(
                collectionView.numberOfItems(inSection: section),
                1
            )
            
            let component = components[section]
            
            let indexPath = IndexPath(
                item: 0,
                section: section
            )
            
            guard
                let cell = component.view.superview?.superview as? UICollectionViewCell
            else {
                
                XCTFail("Must be a UICollectionViewCell.")
                
                return
                
            }
            
            XCTAssertEqual(
                collectionView.cellForItem(at: indexPath),
                cell
            )
            
        }
        
    }
    
}
