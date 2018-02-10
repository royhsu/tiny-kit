//
//  StateComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TrafficLight

import TinyCore

internal enum TrafficLight: String {
    
    case green, yellow, red
    
}

extension TrafficLight: State {
    
    internal func isValidNextState(_ state: State) -> Bool {
        
        guard
            let next = state as? TrafficLight
        else { return false }
        
        let old = self
        
        switch (old, next) {
            
        case
            (.green, .yellow),
            (.yellow, .red),
            (.red, .green):
            return true
            
        default: return false
        }
        
    }
    
}

// MARK: - StateComponentTests

import XCTest

@testable import TinyKit

internal final class StateComponentTests: XCTestCase {
    
    internal final func testStateComponent() {
        
        do {
            
            let greenComponent = ColorComponent(
                contentMode: .size(
                    width: 50.0,
                    height: 50.0
                ),
                view: RectangleView(),
                model: Color(
                    red: 0.0,
                    green: 1.0,
                    blue: 0.0,
                    alpha: 1.0
                ),
                binding: { colorView, color in
                    
                    colorView.backgroundColor = color.uiColor()
                    
                }
            )
            
            let yellowComponent = ColorComponent(
                contentMode: .size(
                    width: 50.0,
                    height: 50.0
                ),
                view: RectangleView(),
                model: Color(
                    red: 0.0,
                    green: 1.0,
                    blue: 1.0,
                    alpha: 1.0
                ),
                binding: { colorView, color in
                    
                    colorView.backgroundColor = color.uiColor()
                    
                }
            )
            
            let redComponent = ColorComponent(
                contentMode: .size(
                    width: 50.0,
                    height: 50.0
                ),
                view: RectangleView(),
                model: Color(
                    red: 1.0,
                    green: 0.0,
                    blue: 0.0,
                    alpha: 1.0
                ),
                binding: { colorView, color in
                    
                    colorView.backgroundColor = color.uiColor()
                    
                }
            )
            
            let stateComponent = StateComponent<TrafficLight>(
                initialComponent: greenComponent,
                initialState: .green
            )
            
            stateComponent.registerComponent(
                yellowComponent,
                for: .yellow
            )
            
            stateComponent.registerComponent(
                redComponent,
                for: .red
            )
            
            XCTAssertEqual(
                stateComponent.currentState,
                .green
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.count,
                1
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.first,
                greenComponent.view
            )
            
            try stateComponent.enter(.yellow)
            
            XCTAssertEqual(
                stateComponent.currentState,
                .yellow
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.count,
                1
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.first,
                yellowComponent.view
            )
            
            try stateComponent.enter(.red)
            
            XCTAssertEqual(
                stateComponent.currentState,
                .red
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.count,
                1
            )
            
            XCTAssertEqual(
                stateComponent.view.subviews.first,
                redComponent.view
            )
            
        }
        catch { XCTFail("\(error)") }
        
    }
    
}
