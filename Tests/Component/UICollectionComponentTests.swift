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
        
        let component = UICollectionComponent()
        
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
        
        component.itemComponents = UIStubComponentCollection(
            numberOfSections: { return components.count },
            numberOfItemsInSection: { section in return 1 },
            componentAtItem: { indexPath in components[indexPath.section] }
        )
        
        component.render()
        
        let collectionView = component.collectionView
        
        let numberOfSections = components.count
        
        XCTAssertEqual(
            collectionView.numberOfSections,
            numberOfSections
        )
        
        for section in 0..<numberOfSections {
            
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
