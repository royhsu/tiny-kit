//
//  UIWindow+ViewRender.swift
//  TinyKit
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRender

import UIKit

extension UIWindow {

    public final func render(with component: Component) {

        rootViewController = ComponentViewController(component: component)

    }

}
