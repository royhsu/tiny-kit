//
//  LegacyCollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacyCollectionViewController

@available(*, deprecated: 1.0, message: "", renamed: "CollectionViewController")
open class LegacyCollectionViewController: ViewController {

    public final let collectionView = LegacyCollectionView()

    public init() {

        super.init(
            nibName: nil,
            bundle: nil
        )

        self.prepare()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        view.wrapSubview(collectionView)

    }

    fileprivate final func prepare() {

        collectionView.layoutDidChange = { [weak self] oldLayout, newLayout in

            let oldViewController = oldLayout?._viewController

            oldViewController?.willMove(toParent: nil)

            oldViewController?.view.removeFromSuperview()

            oldViewController?.removeFromParent()

            guard
                let self = self,
                let newViewController = newLayout?._viewController
            else { return }

            self.addChild(newViewController)

            self.view.wrapSubview(newViewController.view)

            newViewController.didMove(toParent: self)

        }

//        layout.setViewForItem { [weak self] _, indexPath in
//
//            guard
//                let self = self
//            else { return View() }
//
//            let section = self.sections.section(at: indexPath.section)
//
//            let view = section.view(at: indexPath.item)
//
//            if let actionable = view as? Actionable {
//
//                self._observations.append(
//                    actionable.actions.observe { [weak self] change in
//
//                        guard
//                            let action = change.currentValue
//                        else { return }
//
//                        self?._actionDispatcher?(action)
//
//                    }
//                )
//
//            }
//
//            if let failable = view as? Failable {
//
//                self._observations.append(
//                    failable.errors.observe { [weak self] change in
//
//                        guard
//                            let error = change.currentValue
//                        else { return }
//
//                        self?._errorHandler?(error)
//
//                    }
//                )
//
//            }
//
//            return view
//
//        }

    }

}
