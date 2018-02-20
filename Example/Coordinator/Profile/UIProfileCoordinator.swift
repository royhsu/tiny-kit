//
//  UIProfileCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileCoordinator

import Hydra
import TinyKit

public final class UIProfileCoordinator: ViewRenderable {

    private final let stateMachine = StateMachine(initialState: UIProfileState.initial)

    internal final var currentState: UIProfileState {

        // swiftlint:disable force_cast
        return stateMachine.currentState as! UIProfileState
        // swiftlint:enable force_cast

    }

    internal final func component(for state: UIProfileState) -> Component {

        switch state {

        case .initial: return splashComponent

        case .loading: return loadingComponent

        case .loaded: return profileComponent

        }

    }

    public final let userId: String

    private final let userManager = UserManager()

    private final let postManager = PostManager()

    private final let splashComponent: UIItemComponent<UIView>

    private final let loadingComponent: UILoadingComponent

    private final let profileComponent: UIProfileComponent

    public init(
        contentSize: CGSize,
        userId: String
    ) {

        self.userId = userId

        self.splashComponent = UIItemComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            ),
            itemView: UIView()
        )

        self.loadingComponent = UILoadingComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )

        self.profileComponent = UIProfileComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )

    }

    public final func activate() {

        stateMachine.delegate = self

        do {

            switch currentState {

            case .initial:

                splashComponent.render()

                view.render(with: splashComponent)

                try stateMachine.enter(UIProfileState.loading)

            case .loading, .loaded: break

            }

        }
        catch {

            // TODO: show error.
            print("\(error)")

        }

    }

    // MARK: - ViewRenderable

    public final let view = View()

    public final var preferredContentSize: CGSize { return view.bounds.size }

}

// MARK: - StateMachineDelegate

extension UIProfileCoordinator: StateMachineDelegate {

    public final func stateMachine(
        _ stateMachine: StateMachine,
        didChangeFrom old: State,
        to new: State
    ) {

        guard
            let old = old as? UIProfileState,
            let new = new as? UIProfileState
        else { fatalError("Unexpected state.") }

        switch (old, new) {

        case (.initial, .loading):

            loadingComponent.render()

            loadingComponent.startAnimating()

            view.render(with: loadingComponent)

            let fetchUser: Promise<Void> = userManager
                .fetchUser(
                    in: .background,
                    userId: userId
                )
                .then { user -> UIProfileIntroduction in

                    return UIProfileIntroduction(
                        name: user.name,
                        introduction: user.introduction
                    )

                }
                .then(
                    in: .main,
                    profileComponent.setIntroduction
                )

            let fetchPosts: Promise<Void> = postManager
                .fetchPosts(
                    in: .background,
                    userId: userId
                )
                .then { posts -> [UIPost] in

                    return posts.map { post in

                        return UIPost(
                            title: post.title,
                            content: post.content
                        )

                    }

                }
                .then(
                    in: .main,
                    profileComponent.setPosts
                )

            all(
                fetchUser,
                fetchPosts
            )
            .then(in: .main) { _ in

                try self.stateMachine.enter(UIProfileState.loaded)

            }
            .always(
                in: .main,
                body: loadingComponent.stopAnimating
            )

        case (.loading, .loaded):

            profileComponent.render()

            view.render(with: profileComponent)

        default: fatalError("Invalid state transition.")

        }

    }

}
