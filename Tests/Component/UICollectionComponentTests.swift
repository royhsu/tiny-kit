//
//  UICollectionComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponentTests

import XCTest

@testable import TinyKit

internal final class UICollectionComponentTests: XCTestCase {
    
    internal final func testRenderComponent() {
        
        let itemComponents: [Component] = [
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
        
        let collectionComponent = UICollectionComponent(
            collectionLayout: UICollectionViewFlowLayout()
        )
        
        collectionComponent.itemComponents = UIStubComponentCollection(
            numberOfSections: { return itemComponents.count },
            numberOfItemsInSection: { section in return 1 },
            componentAtItem: { indexPath in itemComponents[indexPath.section] }
        )
        
        collectionComponent.render()
        
        let collectionView = collectionComponent.collectionView
        
        let numberOfSections = itemComponents.count
        
        XCTAssertEqual(
            collectionView.numberOfSections,
            numberOfSections
        )
        
        for section in 0..<numberOfSections {
            
            XCTAssertEqual(
                collectionView.numberOfItems(inSection: section),
                1
            )
            
            let indexPath = IndexPath(
                item: 0,
                section: section
            )
            
            let itemComponent = itemComponents[section]
            
            guard
                let cell = itemComponent.view.superview?.superview as? UICollectionViewCell
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
