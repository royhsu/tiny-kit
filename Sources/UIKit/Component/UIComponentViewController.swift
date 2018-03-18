//
//  UIComponentViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIComponentViewController

public final class UIComponentViewController: UIViewController {

    public final let component: Component

    public init(component: Component) {

        self.component = component

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }

    // MAKR: View Life Cycle

    // TODO: [bug] the controller won't be released.
    public final override func loadView() { view = component.view }

}
