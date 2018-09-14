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
        
        let template = PostListTemplate(
            elements: [
                .title,
                .body
            ]
        )
        
        template.registerView(
            TitleLabel.self,
            for: .title
        )
        
        template.registerView(
            LargeTitleLabel.self,
            for: .title
        )
        
        template.registerView(
            BodyLabel.self,
            for: .body
        )
        
        XCTAssertNil(template.configuration)
        
        template.configuration = PostListConfiguration { element in
            
            switch element {
            
            case .title:
                
                // Test a well-fined view name.
                return "LargeTitleLabel"
                
            case .body:
                
                // Test a wrong view name.
                return "Not Found!"
                
            }
            
        }
        
        XCTAssertEqual(
            template.numberOfElements,
            2
        )
        
        XCTAssertEqual(
            template.element(at: 0),
            .title
        )
        
        XCTAssert(
            template.view(for: .title) is LargeTitleLabel
        )
        
        XCTAssertEqual(
            template.element(at: 1),
            .body
        )
        
        XCTAssert(
            template.view(for: .body) is BodyLabel
        )
        
    }
    
}
