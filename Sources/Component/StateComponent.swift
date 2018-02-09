//
//  StateComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

public typealias ComponentState = State & Hashable

public struct AnyComponentState<CS: ComponentState>: ComponentState {
    
    private let base: CS
    
    public init(_ base: CS) { self.base = base }
    
    // MARK: State
    
    public func isValidNextState(_ state: State) -> Bool {
        
        return base.isValidNextState(state)
        
    }
    
    // MARK: Hashable
    
    public var hashValue: Int { return base.hashValue }
    
    public static func ==(
        lhs: AnyComponentState<CS>,
        rhs: AnyComponentState<CS>
    )
    -> Bool { return lhs.base == rhs.base }

}

// MARK: - StateComponent

import TinyCore

open class StateComponent<CS: ComponentState>: Component {
    
    private final let stateMachine: StateMachine<StateComponent>
    
    private final let stateComponentMap: [AnyComponentState<CS>: Component]
    
    public final var currentState: CS { return stateMachine.currentState as! CS }
    
    private final var currentComponent: Component {
        
        let state = AnyComponentState(currentState)
        
        guard
            let component = stateComponentMap[state]
        else { fatalError("No associated compoent found for the current state.") }
        
        return component
        
    }
    
    public init(
        initialComponent: Component,
        initialState: CS
    ) {
        
        let stateMachine = StateMachine<StateComponent>(initialState: initialState)
        
        self.stateMachine = stateMachine
        
        self.stateComponentMap = [
            AnyComponentState(initialState): initialComponent
        ]
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return currentComponent.view }
    
    public final var preferredContentSize: CGSize { return currentComponent.preferredContentSize }
    
}
