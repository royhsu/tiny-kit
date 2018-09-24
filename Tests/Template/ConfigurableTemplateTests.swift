//
//  ConfigurableTemplateTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ConfigurableTemplateTests

import XCTest

internal final class ConfigurableTemplateTests: XCTestCase {
    
    internal final func testInitialize() {
        
        let promise = expectation(description: "Binding the storage with view.")
        
        let post = Post(
            id: 1,
            title: "Hello",
            body: "World"
        )
        
        let template = PostTemplate(
            storage: post,
            elements: [
                .title,
                .body
            ]
        )
        
        XCTAssertEqual(
            template.storage,
            post
        )
        
        XCTAssertEqual(
            template.numberOfViews,
            2
        )
        
        XCTAssert(template.configuration == nil)
        
        template.configuration = PostTemplateConfiguration { element in
            
            switch element {
                
            case .title:
                
                // Test a well-defined view name.
                return "Title2Label"
                
            case .body:
                
                // Test a wrong view name.
                return "Not Found!"
                
            }
            
        }
        
        template.registerView(
            Title1Label.self,
            binding: { _, _ in
                
                XCTFail("Should use the preferred title2 label instead of title2 label.")
                
            },
            for: .title
        )
        
        template.registerView(
            Title2Label.self,
            binding: { storage, label in
                
                promise.fulfill()
                
                XCTAssertEqual(
                    storage,
                    post
                )
                
                label.text = storage.title
                
            },
            for: .title
        )
        
        template.registerView(
            BodyLabel.self,
            binding: (from: \.body, to: \.text),
            for: .body
        )
        
        let titleLabel = template.view(at: 0) as? Title2Label
        
        XCTAssertEqual(
            titleLabel?.text,
            "Hello"
        )
        
        let bodyLabel = template.view(at: 1) as? BodyLabel
        
        XCTAssertEqual(
            bodyLabel?.text,
            "World"
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
