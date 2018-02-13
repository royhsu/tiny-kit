//
//  RedViewController.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RedViewController

import UIKit
import TinyKit

public final class RedViewController: UIViewController {
    
    public final var navigation: Navigation?
    
    private final let button = UIButton(type: .roundedRect)
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(button)
        
        button.setTitle(
            "Go Yellow",
            for: .normal
        )
        
        button.setTitleColor(
            .white,
            for: .normal
        )
        
        button.addTarget(
            self,
            action: #selector(goYellow),
            for: .touchUpInside
        )
        
        button.sizeToFit()
        
    }
    
    public final override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        button.center = view.center
        
    }
    
    @objc
    public final func goYellow(_ sender: Any) {
        
        navigation?.navigate(
            to: URL(string: "tinykit://yellow")!,
            by: .push
        )
        
    }
    
}
