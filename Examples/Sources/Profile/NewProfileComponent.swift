//
//  ProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileComponent

import TinyCore
import TinyKit

public final class ProfileComponent: Component {
    
    public let headerComponent = ProfileHeaderComponent()
    
    public let baseComponent: PostListComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let baseComponent = PostListComponent(contentMode: contentMode)
        
        baseComponent.headerComponent = headerComponent
        
        self.baseComponent = baseComponent
        
    }
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        return all(
            headerComponent.fetch(in: context),
            baseComponent.fetch(in: context)
        )
        .then(in: .main) { _ -> Void in }
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return baseComponent.view }
    
    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return baseComponent.contentMode }
        
        set { baseComponent.contentMode = newValue }
        
    }
    
    public final func render() { baseComponent.render() }
    
}
