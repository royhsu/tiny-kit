//
//  StateComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateComponent

import TinyCore

open class StateComponent<CS: ComponentState>: Component {
    
    private final let stateMachine: StateMachine<StateComponent>
    
    private final var stateComponentMap: [AnyComponentState<CS>: Component]
    
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

public extension StateComponent {
    
    public final func registerComponent(
        _ component: Component,
        for state: CS
    ) {
        
        let state = AnyComponentState(state)
        
        stateComponentMap[state] = component
        
    }
    
    public final func enter(_ state: CS) throws { try stateMachine.enter(state) }
    
}
