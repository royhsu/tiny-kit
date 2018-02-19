//
//  ProfileCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

public enum ProfileState: String, State {

    public func isValidNextState(_ state: State) -> Bool {

        return true

    }

    case loading, loaded

}

public protocol LoadingComponent: Component {

    func startAnimating()

    func stopAnimating()

}

extension UILoadingComponent: LoadingComponent { }

public protocol ProfileIntroduction { }

extension UIProfileIntroduction: ProfileIntroduction { }

public protocol ProfileComponent: Component {

    func setIntroduction(_ introduction: ProfileIntroduction?)

}

extension UIProfileComponent: ProfileComponent {

    public func setIntroduction(_ introduction: ProfileIntroduction?) {

        let introduction = introduction as? UIProfileIntroduction

        setIntroduction(introduction)

    }

}

// MARK: - ProfileCoordinator

import Hydra
import TinyCore
import TinyKit

public final class ProfileCoordinator {

    private final let stateMachine: StateMachine<ProfileCoordinator>

    private final var currentState: ProfileState {

        // swiftlint:disable force_cast
        return stateMachine.currentState as! ProfileState
        // swiftlint:enable force_cast

    }

    private final func component(for state: ProfileState) -> Component {

        switch state {

        case .loading: return loadingComponent

        case .loaded: return profileComponent

        }

    }

    public final let userId: String

    private final let userManager: UserManager

    private final let postManager: PostManager

    private final let loadingComponent: LoadingComponent

    private final let profileComponent: ProfileComponent

    public init(
        userId: String,
        userManager: UserManager,
        postManager: PostManager,
        loadingComponent: LoadingComponent,
        profileComponent: ProfileComponent
    ) {

        self.stateMachine = StateMachine(initialState: ProfileState.loading)

        self.userId = userId

        self.userManager = userManager

        self.postManager = postManager

        self.loadingComponent = loadingComponent

        self.profileComponent = profileComponent

    }

    public func start() {

        stateMachine.eventManger.on(
            .updateCurrentState,
            emit: ProfileCoordinator.handleEvent,
            to: self
        )

        handleEvent(StateMachineEvent.updateCurrentState)

        switch currentState {

        case .loading:

            loadingComponent.startAnimating()

            let fetchUser: Promise<Void> = userManager
                .fetchUser(
                    in: .background,
                    userId: userId
                )
                .then { user -> ProfileIntroduction in

                    return UIProfileIntroduction(
                        name: user.name,
                        introduction: user.introduction
                    )

                }
                .then(
                    in: .main,
                    profileComponent.setIntroduction
                )

            all(fetchUser)
                .then(in: .main) { _ in

                    try self.stateMachine.enter(ProfileState.loaded)

                }
                .always(in: .main) {

                    self.loadingComponent.stopAnimating()

                }

        case .loaded: break

        }

    }

    public final func handleEvent(_ event: Event) {

        let currentComponent = component(for: currentState)

        // TODO: inject dependency.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        appDelegate?.window.rootViewController = ComponentViewController(component: currentComponent)

        currentComponent.render()

    }

}
