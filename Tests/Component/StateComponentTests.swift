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
    
    case red, yellow, green
    
}

extension TrafficLight: State {
    
    internal func isValidNextState(_ state: State) -> Bool {
        
        guard
            let next = state as? TrafficLight
        else { return false }
        
        let old = self
        
        switch (old, next) {
            
        case
            (.red, .green),
            (.green, .yellow),
            (.yellow, .red):
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
            
            let redComponent = ItemComponent(
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
            
            let yellowComponent = ItemComponent(
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
            
            let stateComponent = StateComponent<TrafficLight>(
                initialComponent: redComponent,
                initialState: .red
            )
            
            XCTAssertEqual(
                stateComponent.currentState,
                .red
            )
            
            XCTAssertEqual(
                stateComponent.view,
                redComponent.view
            )
            
//            stateComponent.registerComponent(
//                yellowComponent,
//                for: TrafficLight.yellow
//            )
//
//            try stateComponent.enter(TrafficLight.yellow)
            
        }
        catch { XCTFail("\(error)") }
        
    }
    
}
