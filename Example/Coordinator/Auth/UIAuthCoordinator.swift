//
//  UIAuthCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthCoordinatorDelegate

public protocol UIAuthCoordinatorDelegate: class {

    func coordinate(
        _ coordinate: Coordinator,
        didGrant auth: Auth
    )

}

// MARK: - UIAuthCoordinator

import TinyKit

public final class UIAuthCoordinator: Coordinator {

    private final let navigationController: UINavigationController

    private final let signInComponent: UISignInComponent

    public final weak var delegate: UIAuthCoordinatorDelegate?

    public init(contentSize: CGSize) {

        self.signInComponent = UISignInComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )

        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: signInComponent)
        )

    }

    // MARK: Coordinator

    public final func activate() {

        signInComponent.delegate = self

        signInComponent.render()

    }

}

// MARK: - UISignInComponentDelegate

extension UIAuthCoordinator: UISignInComponentDelegate {

    public final func component(
        _ component: Component,
        didSupplyEmail email: String,
        password: String
    ) {

        BasicAuthManager(
            email: email,
            password: password
        )
        .authorize(in: .background)
        .then(in: .main) { auth in

            self.delegate?.coordinate(
                self,
                didGrant: auth
            )

        }
        .catch(in: .main) { error in print("\(error)") }

    }

}

// MARK: - ViewControllerRepresentable

extension UIAuthCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}
