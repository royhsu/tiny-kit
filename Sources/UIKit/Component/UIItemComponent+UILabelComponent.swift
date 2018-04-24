//
//  UIItemComponent+UILabelComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILabelComponent

extension UIItemComponent: UILabelComponent where ItemView == UILabel {
    
    public final var label: UILabel { return itemView }
    
    public final var text: String? {
        
        get { return label.text }
        
        set { label.text = newValue }
        
    }
    
}
