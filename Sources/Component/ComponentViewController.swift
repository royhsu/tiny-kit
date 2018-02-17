//
//  ComponentViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentViewController

import UIKit

/// A component wrapper that can interact with the UIKit framework
/// For example, adding a UINavigationController to component for navigation.
public final class ComponentViewController: UIViewController {

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

    public final override func loadView() { view = component.view }

}
