//
//  UIProductDetailCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductDetailCoordinator

import TinyKit

public final class ProductDetailCoordinator: Coordinator {
    
    public struct Storage {
        
        public let title: Observable<String?>
        
        public let subtitle: Observable<String?>
        
        public init(
            title: String? = nil,
            subtitle: String? = nil
        ) {
            
            self.title = Observable(title)
            
            self.subtitle = Observable(subtitle)
            
        }
        
    }
    
    public final let storage: Storage
    
    private final let componentViewController: UIComponentViewController
    
    private final let component: ProductDetailComponent
    
    public init(component: ProductDetailComponent) {
        
        self.storage = Storage()
        
        self.componentViewController = UIComponentViewController(component: component)
        
        self.component = component
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        componentViewController.view.backgroundColor = .white
        
        titleSubscription = storage.title.subscribe { [unowned self] _, title in
                
            self.component.setTitle(title)
            
            DispatchQueue.main.async { self.component.render() }
                
        }
        
        subtitleSubscription = storage.subtitle.subscribe { [unowned self] _, subtitle in
            
            self.component.setSubtitle(subtitle)
            
            DispatchQueue.main.async { self.component.render() }
            
        }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() { component.render() }
    
    // MARK: Observer

    private final var titleSubscription: Subscription<String?>?
    
    private final var subtitleSubscription: Subscription<String?>?
    
}

// MARK: - ViewControllerRepresentable

extension ProductDetailCoordinator: ViewControllerRepresentable {
    
    public final var viewController: UIViewController { return componentViewController }
    
}

// MARK: - ProductDetailComponent

public protocol ProductDetailComponent: Component {
    
    @discardableResult
    func setTitle(_ title: String?) -> Self
    
    @discardableResult
    func setSubtitle(_ subtitle: String?) -> Self
    
}

import TinyStore

extension UIProductDetailComponent: ProductDetailComponent { }
