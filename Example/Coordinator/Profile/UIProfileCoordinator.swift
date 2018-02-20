//
//  UIProfileCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileCoordinator

import Hydra
import TinyCore
import TinyKit

public final class UIProfileCoordinator: Coordinator, ViewRenderable {

    private final let stateMachine = StateMachine(initialState: UIProfileState.initial)

    internal final var currentState: UIProfileState {

        // swiftlint:disable force_cast
        return stateMachine.currentState as! UIProfileState
        // swiftlint:enable force_cast

    }

    public final let userId: String

    private final let userManager: UserManager

    private final let postManager: PostManager

    private final let splashComponent: UIItemComponent<UIView>

    private final let loadingComponent: UILoadingComponent

    private final let profileComponent: UIProfileComponent

    private final let messageComponent: UIMessageComponent

    public init(
        contentSize: CGSize,
        userId: String,
        userManager: UserManager,
        postManager: PostManager
    ) {

        self.userId = userId

        self.userManager = userManager

        self.postManager = postManager

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

        self.messageComponent = UIMessageComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )

    }

    // MARK: Coordinator

    public final func activate() {

        switch currentState {

        case .initial:

            stateMachine.delegate = self

            splashComponent.render()

            view.render(with: splashComponent)

            stateMachine.enter(UIProfileState.loading)

        case .loading, .loaded, .error: break

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

            Promise<Void>.zip(
                userManager.fetchUser(
                    in: .background,
                    userId: userId
                ),
                postManager.fetchPosts(
                    in: .background,
                    userId: userId
                )
            )
            .then(in: .main) { result in

                self.stateMachine.enter(
                    UIProfileState.loaded(
                        user: result.0,
                        posts: result.1
                    )
                )

            }
            .catch(in: .main) { error in

                self.stateMachine.enter(
                    UIProfileState.error(error)
                )

            }
            .always(
                in: .main,
                body: loadingComponent.stopAnimating
            )

        case (
            .loading,
            .loaded(let user, let posts)
        ):

            profileComponent.setIntroduction(
                UIProfileIntroduction(
                    pictureImage: nil,
                    name: user.name,
                    introduction: user.introduction
                )
            )

            profileComponent.setPosts(
                posts.map { post in

                    return UIPost(
                        title: post.title,
                        content: post.content
                    )

                }
            )

            profileComponent.render()

            view.render(with: profileComponent)

        case (
            .loading,
            .error(let error)
        ):

            messageComponent.setMessage(
                UIMessage(
                    title: "⚠️",
                    text: "\(error)"
                )
            )

            messageComponent.render()

            view.render(with: messageComponent)

        default: fatalError("Invalid state transition.")

        }

    }

}
