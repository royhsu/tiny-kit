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

    internal final func testInitialize() {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionComponent = UICollectionComponent(layout: layout)
        
        XCTAssertEqual(
            collectionComponent.contentMode,
            .automatic(estimatedSize: .zero)
        )
        
        XCTAssertEqual(
            collectionComponent.collectionView,
            collectionComponent.view
        )
        
        XCTAssertEqual(
            collectionComponent.collectionViewLayout,
            layout
        )
        
        XCTAssertEqual(
            collectionComponent.view.frame,
            .zero
        )
        
        XCTAssertEqual(
            collectionComponent.view.backgroundColor,
            .clear
        )
        
        XCTAssertEqual(
            collectionComponent.numberOfSections,
            0
        )
        
    }
    
    internal final func testRenderWithContentModeSize() {
        
        let collectionComponent = UICollectionComponent(
            contentMode: .size(
                CGSize(
                    width: 500.0,
                    height: 500.0
                )
            ),
            layout: UICollectionViewFlowLayout()
        )
        
        collectionComponent.render()
        
        XCTAssertEqual(
            collectionComponent.view.frame.size,
            CGSize(
                width: 500.0,
                height: 500.0
            )
        )

    }
    
    internal final func testRenderWithContentModeAutomatic() {
       
        let collectionComponent = UICollectionComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            ),
            layout: UICollectionViewFlowLayout()
        )
        
        collectionComponent.setSizeForItem { _, _, _ in
            
            return CGSize(
                width: 100.0,
                height: 100.0
            )
            
        }
        
        collectionComponent.setItemComponents(
            [
                UIItemComponent(
                    itemView: UIView()
                )
            ]
        )
        
        collectionComponent.render()
        
        XCTAssertEqual(
            collectionComponent.view.frame.size,
            CGSize(
                width: 500.0,
                height: 100.0
            )
        )
        
    }

    internal final func testKeepsStrongReferencesToItemComponentsWhileRendering() {
        
        let colorComponentFactory: (UIColor) -> Component = { color in
            
            let component = UIItemComponent(
                itemView: UIView()
            )
            
            component.view.backgroundColor = color
            
            return component
            
        }
        
        let redComponent = colorComponentFactory(.red)
        
        let collectionComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        collectionComponent.setItemComponents(
            [ redComponent ]
        )
        
        collectionComponent.render()
        
        XCTAssertEqual(
            collectionComponent.itemComponentMap.count,
            1
        )
        
        let firstItemIndexPath = IndexPath(
            item: 0,
            section: 0
        )
        
        XCTAssert(
            collectionComponent.itemComponentMap[firstItemIndexPath]
            === redComponent
        )
        
        let blueComponent = colorComponentFactory(.blue)
        
        collectionComponent.setItemComponents(
            [ blueComponent ]
        )
        
        collectionComponent.render()
        
        XCTAssertEqual(
            collectionComponent.itemComponentMap.count,
            1
        )
        
        XCTAssert(
            collectionComponent.itemComponentMap[firstItemIndexPath]
            === blueComponent
        )
        
    }
    
    internal final func testGetItemComponentByIndexPath() {
        
        let squareComponent = UIItemComponent(
            itemView: UIView()
        )
        
        let collectionComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        collectionComponent.setItemComponents(
            [ squareComponent ]
        )
        
        collectionComponent.render()
        
        let firstItemIndexPath = IndexPath(
            item: 0,
            section: 0
        )
        
        XCTAssert(
            collectionComponent.itemComponent(at: firstItemIndexPath)
            === squareComponent
        )
        
    }
    
}
