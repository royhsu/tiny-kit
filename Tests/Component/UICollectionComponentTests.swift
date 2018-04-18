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
        
        let collectionComponent = UICollectionComponent(
            layout: layout
        )
        
        XCTAssertEqual(
            collectionComponent.contentMode,
            .automatic2(estimatedSize: .zero)
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
    
    internal final func testRenderComponent() {

//        let itemComponents: [Component] = [
//            UIItemComponent(
//                contentMode: .size(
//                    width: 100.0,
//                    height: 100.0
//                ),
//                itemView: RectangleView()
//            ),
//            UIItemComponent(
//                contentMode: .size(
//                    width: 200.0,
//                    height: 200.0
//                ),
//                itemView: RectangleView()
//            )
//        ]
//
//        let collectionComponent = UICollectionComponent()
//
//        let sections = 1
//
//        collectionComponent
//            .setNumberOfSections { sections }
//            .setNumberOfItems { _ in itemComponents.count }
//            .setComponentForItem { itemComponents[$0.section] }
//            .render()
//
//        let collectionView = collectionComponent.collectionView
//
//        XCTAssertEqual(
//            collectionView.numberOfSections,
//            sections
//        )
//
//        for section in 0..<sections {
//
//            let items = collectionView.numberOfItems(inSection: section)
//
//            for item in 0..<items {
//
//                let indexPath = IndexPath(
//                    item: item,
//                    section: section
//                )
//
//                let itemComponent = itemComponents[section]
//
//                guard
//                    let cell = itemComponent.view.superview?.superview as? UICollectionViewCell
//                else {
//
//                    XCTFail("Must be a UICollectionViewCell.")
//
//                    return
//
//                }
//
//                XCTAssertEqual(
//                    collectionView.cellForItem(at: indexPath),
//                    cell
//                )
//
//            }
//
//        }

    }

}
