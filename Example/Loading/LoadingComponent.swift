//
//  LoadingComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LoadingComponent

import TinyKit

public final class LoadingComponent: Component {
    
    private typealias BaseComponent = ItemComponent<LoadingView, Loading>
    
    private final let baseComponent: BaseComponent
    
    private final let baseView: LoadingView
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        loading: Loading = Loading()
    ) {
        
        let baseView = UIView.load(LoadingView.self)!
        
        self.baseView = baseView
        
        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            view: baseView,
            model: loading,
            binding: { loadingView, loading in }
        )
        
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

public extension LoadingComponent {
    
    public final var loading: Loading {
        
        get { return baseComponent.model }
        
        set { baseComponent.model = newValue }
        
    }
    
}

public extension LoadingComponent {
    
    public final func startAnimating() { baseView.activityIndicatorView.startAnimating() }
    
    public final func stopAnimating() { baseView.activityIndicatorView.stopAnimating() }
    
}
