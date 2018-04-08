//
//  UIProfileCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileCoordinatorDelegate

public protocol UIProfileCoordinatorDelegate: class {

    func coordinatorDidSignOut(_ coordinator: Coordinator)

}

// MARK: - UIProfileCoordinator

import Hydra
import TinyCore
import TinyKit

public final class UIProfileCoordinator: Coordinator {

    private final let navigationController: UINavigationController

    private final let containerViewController: UIViewController

    private final var containerView: View { return containerViewController.view }

    private final let stateMachine: StateMachine

    private final var currentState: UIProfileState {

        // swiftlint:disable force_cast
        return stateMachine.currentState as! UIProfileState
        // swiftlint:enable force_cast

    }

    private final var currentComponent: Component {

        switch currentState {

        case .initial: return splashComponent

        case .loading: return loadingComponent

        case .loaded: return profileComponent

        case .error: return messageComponent

        }

    }

    public final let accessToken: AccessToken

    private final let userManager: UserManager

    private final let postManager: PostManager

    private final let splashComponent: UIItemComponent<UIView>

    private final let loadingComponent: UILoadingComponent

    private final let profileComponent: UIProfileComponent

    private final let messageComponent: UIMessageComponent

    public final weak var delegate: UIProfileCoordinatorDelegate?

    public init(
        contentSize: CGSize,
        accessToken: AccessToken,
        userManager: UserManager,
        postManager: PostManager
    ) {

        self.accessToken = accessToken

        self.userManager = userManager

        self.postManager = postManager

        self.stateMachine = StateMachine(initialState: UIProfileState.initial)

        let containerViewController = UIViewController()

        containerViewController.view.frame.size = contentSize

        self.containerViewController = containerViewController

        self.navigationController = UINavigationController(rootViewController: containerViewController)

        self.splashComponent = UIItemComponent(
            contentMode: .size(contentSize),
            itemView: UIView()
        )

        self.loadingComponent = UILoadingComponent(
            contentMode: .size(contentSize)
        )

        self.profileComponent = UIProfileComponent(
            contentMode: .size(contentSize),
            listComponent: UIListComponent()
        )

        self.messageComponent = UIMessageComponent(
            contentMode: .size(contentSize)
        )

    }

    // MARK: Coordinator

    public final func activate() {

        switch currentState {

        case .initial:

            stateMachine.delegate = self

            splashComponent.render()

            containerView.render(with: splashComponent)

            stateMachine.enter(UIProfileState.loading)

        case .loading, .loaded, .error: break

        }

    }

    // MARK: Action

    @objc
    public final func handleSignOut() { delegate?.coordinatorDidSignOut(self) }

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

            containerView.render(with: loadingComponent)

            Promise<Void>.zip(
                userManager.fetchMe(
                    in: .background,
                    accessToken: accessToken
                ),
                postManager.fetchMyPosts(
                    in: .background,
                    accessToken: accessToken
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

            containerView.render(with: profileComponent)

            containerViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString(
                    "Sign Out",
                    comment: ""
                ),
                style: .plain,
                target: self,
                action: #selector(handleSignOut)
            )

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

            containerView.render(with: messageComponent)

        default: fatalError("Invalid state transition.")

        }

    }

}

// MARK: - ViewControllerRepresentable

extension UIProfileCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}
