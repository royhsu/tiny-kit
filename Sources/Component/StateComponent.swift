//
//  StateComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateComponent

import TinyCore

public final class StateComponent<CS: ComponentState>: Component {

    private final let stateMachine: StateMachine<StateComponent>

    private final var stateComponentMap: [AnyComponentState<CS>: Component]

    public init(
        contentMode: ComponentContentMode = .automatic,
        initialComponent: Component,
        initialState: CS
    ) {

        self.contentMode = contentMode

        let stateMachine = StateMachine<StateComponent>(initialState: initialState)

        self.stateMachine = stateMachine

        self.stateComponentMap = [
            AnyComponentState(initialState): initialComponent
        ]

    }

    // MARK: ViewRenderable

    public final let view = View()

    public final var preferredContentSize: CGSize { return view.bounds.size }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        for state in stateComponentMap.keys {

            stateComponentMap[state]?.contentMode = contentMode

        }

        view.subviews.forEach { $0.removeFromSuperview() }

        let currentView = currentComponent.view

        currentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(currentView)

        NSLayoutConstraint.activate(
            [
                view
                    .leadingAnchor
                    .constraint(equalTo: currentView.leadingAnchor),
                view
                    .topAnchor
                    .constraint(equalTo: currentView.topAnchor),
                view
                    .trailingAnchor
                    .constraint(equalTo: currentView.trailingAnchor)
            ]
        )

        currentComponent.render()

        let size: CGSize

        switch contentMode {

        case .size(let width, let height):

            size = CGSize(
                width: width,
                height: height
            )

        case .automatic:

            size = currentComponent.preferredContentSize

        }

        var frame = view.frame

        frame.size = size

        view.frame = frame

        NSLayoutConstraint.activate(
            [
                view
                    .bottomAnchor
                    .constraint(equalTo: currentView.bottomAnchor)
            ]
        )

        currentView.layoutIfNeeded()

    }

}

public extension StateComponent {

    public final var currentState: CS {

        // swiftlint:disable force_cast
        return stateMachine.currentState as! CS
        // swiftlint:enable force_cast

    }

    private final var currentComponent: Component {

        let state = AnyComponentState(currentState)

        guard
            let component = stateComponentMap[state]
        else { fatalError("No associated component found for the current state.") }

        return component

    }

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
