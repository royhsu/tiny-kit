//
//  PaletteViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PaletteViewController

import TinyKit

/// To demonstrate different layout for each section.
public final class PaletteViewController: ViewController {
    
    private let base = CollectionViewController()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        base.layout = ListViewLayout()
        
        base.sections = [
            PaletteTemplate.horizontal(
                HorizontalGradientTemplate(
                    startColor: DynamicColor(hexString: "#654ea3"),
                    endColor: DynamicColor(hexString: "#eaafc8"),
                    amount: 10
                )
            ),
            PaletteTemplate.vertical(
                VerticalGradientTemplate(
                    startColor: DynamicColor(hexString: "#1d976c"),
                    endColor: DynamicColor(hexString: "#93f9b9"),
                    amount: 10
                )
            ),
            PaletteTemplate.horizontal(
                HorizontalGradientTemplate(
                    startColor: DynamicColor(hexString: "#c21500"),
                    endColor: DynamicColor(hexString: "#ffc500"),
                    amount: 10
                )
            )
        ]
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
