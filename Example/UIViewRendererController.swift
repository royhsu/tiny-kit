//
//  UIViewRendererController.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIViewRendererController

import TinyKit

public final class UIViewRendererController: UIViewController {

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
