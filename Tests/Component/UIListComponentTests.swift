//
//  UIListComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponentTests

import XCTest

@testable import TinyKit

internal final class UIListComponentTests: XCTestCase {
    
    internal final func testInitialize() {
        
        let listComponent = UIListComponent()
        
        XCTAssertEqual(
            listComponent.contentMode,
            .automatic(estimatedSize: .zero)
        )
        
        XCTAssertEqual(
            listComponent.tableView,
            listComponent.view
        )
        
        XCTAssertEqual(
            listComponent.tableView.style,
            .plain
        )
        
        XCTAssertEqual(
            listComponent.view.frame,
            .zero
        )
        
        XCTAssertEqual(
            listComponent.view.backgroundColor,
            .clear
        )
        
        XCTAssertEqual(
            listComponent.numberOfSections,
            0
        )
        
        XCTAssertNil(listComponent.headerComponent)
        
        XCTAssertNil(listComponent.footerComponent)
        
    }

    internal final func testRenderWithContentModeSize() {
        
        let listComponent = UIListComponent(
            contentMode: .size(
                CGSize(
                    width: 500.0,
                    height: 500.0
                )
            )
        )
    
        listComponent.render()
        
        XCTAssertEqual(
            listComponent.view.frame.size,
            CGSize(
                width: 500.0,
                height: 500.0
            )
        )
        
    }
    
    internal final func testRenderWithContentModeAutomatic() {

        let listComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )

        listComponent.setItemComponents(
            [
                UIItemComponent(
                    contentMode: .size(
                        CGSize(
                            width: 100.0,
                            height: 100.0
                        )
                    ),
                    itemView: UIView()
                )
            ]
        )

        listComponent.render()
        
        XCTAssertEqual(
            listComponent.view.frame.size,
            CGSize(
                width: 500.0,
                height: 100.0
            )
        )
        
    }
    
    internal final func testRenderHeaderComponent() {
        
        let squareComponent = UIItemComponent(
            contentMode: .size(
                CGSize(
                    width: 100.0,
                    height: 100.0
                )
            ),
            itemView: UIView()
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        listComponent.headerComponent = squareComponent
        
        listComponent.render()
    
        XCTAssertEqual(
            listComponent.tableView.tableHeaderView,
            squareComponent.view
        )
        
        XCTAssertEqual(
            listComponent.headerComponent?.view.frame.size,
            CGSize(
                width: 500.0,
                height: 100.0
            )
        )
        
    }
    
    internal final func testRenderFooterComponent() {
        
        let squareComponent = UIItemComponent(
            contentMode: .size(
                CGSize(
                    width: 100.0,
                    height: 100.0
                )
            ),
            itemView: UIView()
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        listComponent.footerComponent = squareComponent
        
        listComponent.render()
        
        XCTAssertEqual(
            listComponent.tableView.tableFooterView,
            squareComponent.view
        )
        
        XCTAssertEqual(
            listComponent.footerComponent?.view.frame.size,
            CGSize(
                width: 500.0,
                height: 100.0
            )
        )
        
    }
    
    internal final func testRenderingKeepsStrongReferencesToItemComponents() {
        
        let colorComponentFactory: (UIColor) -> Component = { color in
            
            let component = UIItemComponent(
                contentMode: .size(
                    CGSize(
                        width: 100.0,
                        height: 100.0
                    )
                ),
                itemView: UIView()
            )
            
            component.view.backgroundColor = color
            
            return component
            
        }
        
        let redComponent = colorComponentFactory(.red)
        
        let listComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        listComponent.setItemComponents(
            [ redComponent ]
        )
        
        listComponent.render()
        
        XCTAssertEqual(
            listComponent.itemComponentMap.count,
            1
        )
        
        let firstItemIndexPath = IndexPath(
            item: 0,
            section: 0
        )
        
        XCTAssert(
            listComponent.itemComponentMap[firstItemIndexPath]
            === redComponent
        )
        
        let blueComponent = colorComponentFactory(.blue)
        
        listComponent.setItemComponents(
            [ blueComponent ]
        )
        
        listComponent.render()
        
        XCTAssertEqual(
            listComponent.itemComponentMap.count,
            1
        )
        
        XCTAssert(
            listComponent.itemComponentMap[firstItemIndexPath]
            === blueComponent
        )
        
    }
    
    internal final func testGetItemComponentByIndexPath() {
        
        let squareComponent = UIItemComponent(
            contentMode: .size(
                CGSize(
                    width: 100.0,
                    height: 100.0
                )
            ),
            itemView: UIView()
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic(
                estimatedSize: CGSize(
                    width: 500.0,
                    height: 50.0
                )
            )
        )
        
        listComponent.setItemComponents(
            [ squareComponent ]
        )
        
        listComponent.render()
        
        let firstItemIndexPath = IndexPath(
            item: 0,
            section: 0
        )
        
        XCTAssert(
            listComponent.itemComponent(at: firstItemIndexPath)
            === squareComponent
        )
        
    }
    
}
