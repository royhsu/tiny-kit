//
//  RootViewController.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RootViewController

import Hydra
import UIKit
import TinyKit

public final class RootViewController: UIViewController {

    public final let renderable: ViewRenderable

    public init(renderable: ViewRenderable) {

        self.renderable = renderable

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }

    // MAKR: View Life Cycle

    public final override func loadView() { view = renderable.view }

}

// MARK: - ViewRender

import TinyCore

extension RootViewController: ViewRender {

    public final var renderables: AnyCollection<ViewRenderable> {

        return AnyCollection(
            [ renderable ]
        )

    }

    public final func render() -> Promise<Void> {

        return Promise(in: .main) { fulfill, _, _ in

            self.view.layoutSubviews()

            let result: Void = ()

            fulfill(result)

        }

    }

}
