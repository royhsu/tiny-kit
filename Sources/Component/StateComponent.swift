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
        
        updateCurrentView()
        
    }
    
    fileprivate final func updateCurrentView() {
        
        let currentView = currentComponent.view
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(currentView)
        
        NSLayoutConstraint.activate(
            [
                currentView
                    .leadingAnchor
                    .constraint(equalTo: view.leadingAnchor),
                currentView
                    .topAnchor
                    .constraint(equalTo: view.topAnchor),
                currentView
                    .trailingAnchor
                    .constraint(equalTo: view.trailingAnchor),
                currentView
                    .bottomAnchor
                    .constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    // MARK: ViewRenderable
    
    public final let view = View()
    
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
    
    public final func enter(_ state: CS) throws {
        
        try stateMachine.enter(state)
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        updateCurrentView()
        
    }
    
}
