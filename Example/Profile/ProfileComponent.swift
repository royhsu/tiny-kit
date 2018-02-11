//
//  ProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileComponent

import Hydra
import TinyCore
import TinyKit

public final class ProfileComponent: Component {
    
    private final let initialComponent: SplashComponent
    
    private final let loadingComponent: LoadingComponent
    
    private final let messageComponent: MessageComponent
    
    private final let headerComponent = ProfileHeaderComponent()
    
    private final let postListComponent: PostListComponent
    
    private typealias BaseComponent = StateComponent<ProfileComponentState>
    
    private final let baseComponent: BaseComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let initialComponent = SplashComponent(contentMode: contentMode)
        
        self.initialComponent = initialComponent
        
        let loadingComponent = LoadingComponent(contentMode: contentMode)
        
        self.loadingComponent = loadingComponent
        
        let messageComponent = MessageComponent(contentMode: contentMode)
        
        self.messageComponent = messageComponent
        
        let postListComponent = PostListComponent(contentMode: contentMode)
        
        postListComponent.headerComponent = headerComponent
        
        self.postListComponent = postListComponent
        
        let baseComponent = BaseComponent(
            contentMode: contentMode,
            initialComponent: initialComponent,
            initialState: .initial
        )
        
        baseComponent.registerComponent(
            loadingComponent,
            for: .loading
        )
        
        baseComponent.registerComponent(
            messageComponent,
            for: .error
        )
        
        baseComponent.registerComponent(
            postListComponent,
            for: .loaded
        )
        
        self.baseComponent = baseComponent
        
    }
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        try! baseComponent.enter(.loading)
        
        loadingComponent.startAnimating()
        
        render()
        
        return all(
            headerComponent.fetch(in: context).always(in: context) { },
            postListComponent.fetch(in: context).always(in: context) { }
        )
        .then(in: .main) { _ -> Void in try self.baseComponent.enter(.loaded) }
        .catch(in: .main) { error in
            
            try self.baseComponent.enter(.error)
            
            self.messageComponent.message = Message(error: error)
            
        }
        .always(in: .main) { self.loadingComponent.stopAnimating() }
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return baseComponent.view }
    
    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return baseComponent.contentMode }
        
        set { baseComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        loadingComponent.render()
        
        messageComponent.render()
        
        postListComponent.render()
        
        baseComponent.render()
        
    }
    
}
