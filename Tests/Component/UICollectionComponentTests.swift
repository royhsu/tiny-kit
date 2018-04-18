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
    
    internal final func testRenderWithContentModeSize() {

        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 30.0,
            height: 30.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let collectionSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        let collectionComponent = UICollectionComponent(
            contentMode: .size(collectionSize),
            layout: UICollectionViewFlowLayout()
        )
        
        collectionComponent.setSizeForItem { _, _ in redSize }
        
        collectionComponent.setItemComponents(
            [ redComponent ]
        )
        
        collectionComponent.render()
        
        XCTAssertEqual(
            collectionComponent.view.frame.size,
            collectionSize
        )

    }
    
    internal final func testRenderWithContentModeAutomatic() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 30.0,
            height: 30.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let blueView = UIView()
        
        blueView.backgroundColor = .blue
        
        let blueSize = CGSize(
            width: 40.0,
            height: 40.0
        )
        
        let blueComponent = UIItemComponent(
            contentMode: .size(blueSize),
            itemView: blueView
        )
        
        let estimatedCollectionSize = CGSize(
            width: 200.0,
            height: 200.0
        )
        
        let collectionComponent = UICollectionComponent(
            contentMode: .automatic2(estimatedSize: estimatedCollectionSize),
            layout: UICollectionViewFlowLayout()
        )
        
        collectionComponent.setSizeForItem { _, indexPath in
            
            switch indexPath.item {
                
            case 0: return redSize
                
            case 1: return blueSize
                
            default: XCTFail("Undefined item.") ; return .zero
                
            }
            
        }
        
        collectionComponent.setItemComponents(
            [
                redComponent,
                blueComponent
            ]
        )
        
        collectionComponent.render()
        
        XCTAssertNotEqual(
            collectionComponent.view.frame.size,
            estimatedCollectionSize
        )
        
        XCTAssertEqual(
            collectionComponent.view.frame.size,
            CGSize(
                width: estimatedCollectionSize.width,
                height: blueSize.height
            )
        )
        
    }

}
