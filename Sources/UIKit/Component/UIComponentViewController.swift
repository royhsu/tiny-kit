//
//  UIComponentViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIComponentViewController

// TODO: [bug] the controller won't be released.
public final class UIComponentViewController: UIViewController {

    public final var component: Component

    public init(component: Component) {

        self.component = component

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }

    // MAKR: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.render(with: component)
        
    }
    
    public override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        component.contentMode = .size(
            width: view.bounds.width,
            height: view.bounds.height
        )
        
        component.render()
        
    }

}
