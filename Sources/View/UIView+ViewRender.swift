//
//  UIView+ViewRender.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

import UIKit

extension UIView: ViewRender {
    
    public final func render(_ renderable: ViewRenderable) {
        
        let contentView = renderable.view
        
        contentView.removeFromSuperview()
        
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                contentView
                    .leadingAnchor
                    .constraint(equalTo: leadingAnchor),
                contentView
                    .topAnchor
                    .constraint(equalTo: topAnchor),
                contentView
                    .trailingAnchor
                    .constraint(equalTo: trailingAnchor),
                contentView
                    .bottomAnchor
                    .constraint(equalTo: bottomAnchor)
            ]
        )
        
    }
    
}
