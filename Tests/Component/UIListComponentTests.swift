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
            .automatic2(estimatedSize: .zero)
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
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 100.0,
            height: 100.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let listSize = CGSize(
            width: 500.0,
            height: 500.0
        )
        
        let listComponent = UIListComponent(
            contentMode: .size(listSize)
        )
        
        listComponent.setItemComponents(
            [ redComponent ]
        )
        
        listComponent.render()
        
        let expectedRedComponent = listComponent.itemComponent(
            at: IndexPath(
                row: 0,
                section: 0
            )
        )
        
        XCTAssertEqual(
            .red,
            expectedRedComponent.view.backgroundColor
        )
        
        XCTAssertEqual(
            CGSize(
                width: listComponent.view.frame.width,
                height: redSize.height
            ),
            expectedRedComponent.view.frame.size
        )
        
        XCTAssertEqual(
            listComponent.view.frame.size,
            listSize
        )
        
    }
    
    internal final func testRenderWithContentModeAutomatic() {

        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 100.0,
            height: 100.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.text = "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper."
        
        let estimatedLabelSize = CGSize(
            width: 500.0,
            height: 50.0
        )
        
        let expectedLabelSize = label.sizeThatFits(estimatedLabelSize)
        
        let labelComponent = UIItemComponent(
            contentMode: .automatic2(estimatedSize: estimatedLabelSize),
            itemView: label
        )
        
        let itemComponents: [Component] = [
            redComponent,
            labelComponent
        ]
        
        let estimatedListSize = CGSize(
            width: 500.0,
            height: 500.0
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic2(estimatedSize: estimatedListSize)
        )

        listComponent.setItemComponents(itemComponents)

        listComponent.render()
        
        XCTAssertEqual(
            listComponent.numberOfSections,
            1
        )
            
        XCTAssertEqual(
            listComponent.numberOfItemComponents(inSection: 0),
            itemComponents.count
        )

        let expectedRedComponent = listComponent.itemComponent(
            at: IndexPath(
                row: 0,
                section: 0
            )
        )
                
        XCTAssertEqual(
            .red,
            expectedRedComponent.view.backgroundColor
        )

        XCTAssertEqual(
            CGSize(
                width: listComponent.view.frame.width,
                height: redSize.height
            ),
            expectedRedComponent.view.frame.size
        )
        
        let expectedLabelComponent = listComponent.itemComponent(
            at: IndexPath(
                row: 1,
                section: 0
            )
        ) as? UIItemComponent<UILabel>
        
        let expectedLabel = expectedLabelComponent?.itemView
        
        XCTAssertEqual(
            label.text,
            expectedLabel?.text
        )
        
        XCTAssertEqual(
            CGSize(
                width: listComponent.view.frame.width,
                height: expectedLabelSize.height
            ),
            expectedLabelComponent?.view.frame.size
        )
        
        XCTAssertEqual(
            listComponent.view.frame.size,
            CGSize(
                width: listComponent.view.frame.width,
                height: redSize.height + expectedLabelSize.height
            )
        )
        
    }
    
    internal final func testHeaderComponent() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 100.0,
            height: 100.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let estimatedListSize = CGSize(
            width: 500.0,
            height: 500.0
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic2(estimatedSize: estimatedListSize)
        )
        
        listComponent.headerComponent = redComponent
        
        listComponent.render()
        
        let tableView = listComponent.tableView

        XCTAssertEqual(
            tableView.tableHeaderView,
            redComponent.view
        )
        
        XCTAssertEqual(
            tableView.tableHeaderView?.frame.size,
            CGSize(
                width: estimatedListSize.width,
                height: redSize.height
            )
        )
        
    }
    
    internal final func testFooterComponent() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redSize = CGSize(
            width: 100.0,
            height: 100.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(redSize),
            itemView: redView
        )
        
        let estimatedListSize = CGSize(
            width: 500.0,
            height: 500.0
        )
        
        let listComponent = UIListComponent(
            contentMode: .automatic2(estimatedSize: estimatedListSize)
        )
        
        listComponent.footerComponent = redComponent
        
        listComponent.render()
        
        let tableView = listComponent.tableView
        
        XCTAssertEqual(
            tableView.tableFooterView,
            redComponent.view
        )
        
        XCTAssertEqual(
            tableView.tableFooterView?.frame.size,
            CGSize(
                width: estimatedListSize.width,
                height: redSize.height
            )
        )
        
    }

}
