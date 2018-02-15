//
//  ComponentViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentViewController

import UIKit

public final class ComponentViewController: UIViewController {
    
    public final func render(component: Component) {
        
        let contentView = component.view
        
        contentView.removeFromSuperview()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate(
            [
                view
                    .leadingAnchor
                    .constraint(equalTo: contentView.leadingAnchor),
                view
                    .topAnchor
                    .constraint(equalTo: contentView.topAnchor),
                view
                    .trailingAnchor
                    .constraint(equalTo: contentView.trailingAnchor),
            ]
        )
        
        component.render()
        
        preferredContentSize = component.preferredContentSize
        
//        NSLayoutConstraint.activate(
//            [
//                view
//                    .bottomAnchor
//                    .constraint(equalTo: contentView.bottomAnchor)
//            ]
//        )
        
    }
    
}
