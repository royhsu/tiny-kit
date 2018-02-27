//
//  UILandingComponent.swift
//  TinyLanding
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingComponent

public final class UILandingComponent: Component {
    
    /// The base component.
    private final var listComponent: ListComponent
    
    public init(
        listComponent: ListComponent = UIListComponent()
    ) { self.listComponent = listComponent }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() { listComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}
