//
//  PaletteViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PaletteViewController

import TinyKit

public final class PaletteViewController: ViewController {
    
    private let base = CollectionViewController()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        base.layout = ListViewLayout()
        
        base.sections = [
            PaletteTemplate.ultraViolet(
                UltraVioletGradient()
            ),
            PaletteTemplate.mojito(
                MojitoGradient()
            )
        ]
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
