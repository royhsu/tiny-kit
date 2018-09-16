//
//  ConfigurableTemplateTests.swift
//  TinyKit iOS
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ConfigurableTemplateTests

import XCTest

internal final class ConfigurableTemplateTests: XCTestCase {
    
    internal final func testInitialize() {
        
        let bindingTitle2Promise = expectation(description: "Binding the storage with title2 label.")
        
        let bindingBodyPromise = expectation(description: "Binding the storage with body label.")
        
        let post = Post(
            id: 1,
            title: "This is the title.",
            body: "This is the body."
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
            template.numberOfElements,
            2
        )
        
        XCTAssertNil(template.configuration)
        
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
            binding: { storage, view in
                
                bindingTitle2Promise.fulfill()
                
                XCTAssertEqual(
                    storage,
                    post
                )
                
                XCTAssertNotNil(view as? Title2Label)
                
            },
            for: .title
        )
        
        template.registerView(
            BodyLabel.self,
            binding: { storage, view in
                
                bindingBodyPromise.fulfill()
                
                XCTAssertEqual(
                    storage,
                    post
                )
                
            },
            for: .body
        )
        
        XCTAssert(
            template.view(at: 0) is Title2Label
        )
        
        XCTAssert(
            template.view(at: 1) is BodyLabel
        )
        
        wait(
            for: [
                bindingTitle2Promise,
                bindingBodyPromise
            ],
            timeout: 10.0
        )
        
    }
    
}
