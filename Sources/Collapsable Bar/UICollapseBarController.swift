//
//  UICollapseBarController.swift
//  TinyKit
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollapseBarController

public final class UICollapseBarController: UIViewController {

    public final var collapseView: UICollapseView { return view as! UICollapseView }

    public private(set) var isCollapsed: Bool = true

    public private(set) final var backgroundViewController: UIViewController?

    public private(set) final var barViewController: UIViewController?

    // TODO: fix the problem that the content will shrink by its child component.
    public private(set) final var barContentViewController: UIViewController?

    public final override func loadView() {

        let bundle = Bundle(
            for: type(of: self)
        )

        view = UIView.load(
            UICollapseView.self,
            from: bundle
        )!

    }

}

public extension UICollapseBarController {

    public final func setCollapsed(
        _ isCollapsed: Bool,
        animated: Bool
    ) {

        if self.isCollapsed == isCollapsed { return }

        self.isCollapsed = isCollapsed

        if isCollapsed {

            NSLayoutConstraint.deactivate(
                [ collapseView.barContainerViewTopConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContainerViewHeightConstraint ]
            )

        }
        else {

            NSLayoutConstraint.deactivate(
                [ collapseView.barContainerViewHeightConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContainerViewTopConstraint ]
            )

        }

        collapseView.setNeedsUpdateConstraints()

        if animated {

            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 1.0,
                options: [],
                animations: { self.collapseView.layoutIfNeeded() },
                completion: nil
            )

        }
        else { collapseView.layoutIfNeeded() }

    }

    public final func setBackgroundViewController(_ viewController: UIViewController) {

        if let existingViewController = backgroundViewController {

            existingViewController.willMove(toParentViewController: nil)

            existingViewController.view.removeFromSuperview()

            existingViewController.removeFromParentViewController()

        }

        addChildViewController(viewController)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        collapseView.backgroundView.addSubview(viewController.view)

        NSLayoutConstraint.activate(
            [
                collapseView
                    .backgroundView
                    .leadingAnchor
                    .constraint(equalTo: viewController.view.leadingAnchor),
                collapseView
                    .backgroundView
                    .topAnchor
                    .constraint(equalTo: viewController.view.topAnchor),
                collapseView
                    .backgroundView
                    .trailingAnchor
                    .constraint(equalTo: viewController.view.trailingAnchor),
                collapseView
                    .backgroundView
                    .bottomAnchor
                    .constraint(equalTo: viewController.view.bottomAnchor)
            ]
        )

        viewController.didMove(toParentViewController: self)

        backgroundViewController = viewController

    }

    public final func setBarViewController(_ viewController: UIViewController) {

        if let existingViewController = barViewController {

            existingViewController.willMove(toParentViewController: nil)

            existingViewController.view.removeFromSuperview()

            existingViewController.removeFromParentViewController()

        }

        addChildViewController(viewController)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        collapseView.barView.addSubview(viewController.view)

        NSLayoutConstraint.activate(
            [
                collapseView
                    .barView
                    .leadingAnchor
                    .constraint(equalTo: viewController.view.leadingAnchor),
                collapseView
                    .barView
                    .topAnchor
                    .constraint(equalTo: viewController.view.topAnchor),
                collapseView
                    .barView
                    .trailingAnchor
                    .constraint(equalTo: viewController.view.trailingAnchor),
                collapseView
                    .barView
                    .bottomAnchor
                    .constraint(equalTo: viewController.view.bottomAnchor)
            ]
        )

        viewController.didMove(toParentViewController: self)

        barViewController = viewController

    }

    public final func setBarContentViewController(_ viewController: UIViewController) {

        if let existingViewController = barContentViewController {

            existingViewController.willMove(toParentViewController: nil)

            existingViewController.view.removeFromSuperview()

            existingViewController.removeFromParentViewController()

        }

        addChildViewController(viewController)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        collapseView.barContentView.addSubview(viewController.view)

        NSLayoutConstraint.activate(
            [
                collapseView
                    .barContentView
                    .leadingAnchor
                    .constraint(equalTo: viewController.view.leadingAnchor),
                collapseView
                    .barContentView
                    .topAnchor
                    .constraint(equalTo: viewController.view.topAnchor),
                collapseView
                    .barContentView
                    .trailingAnchor
                    .constraint(equalTo: viewController.view.trailingAnchor),
                collapseView
                    .barContentView
                    .bottomAnchor
                    .constraint(equalTo: viewController.view.bottomAnchor)
            ]
        )

        viewController.didMove(toParentViewController: self)

        barContentViewController = viewController

    }

}
