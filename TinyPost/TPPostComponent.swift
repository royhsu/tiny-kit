//
//  TPPostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostComponent

public final class TPPostComponent: PostComponent {
    
    /// The base component.
    private final let layoutComponent: ListComponent
    
    public init(layoutComponent: ListComponent) {
        
        self.layoutComponent = layoutComponent
        
        self.numberOfElementComponents = 0
        
        self.prepare()
        
    }
    
    // MARK: PostComponent
    
    public final var numberOfElementComponents: Int
    
    public final func elementComponent(at index: Int) -> ElementComponent {
        
        guard
            let element = elementComponentProvider?(
                self,
                index
            )
        else { fatalError("Please make sure to set the element provider with function setElementComponent(provider:) firstly.") }
        
        return element
        
    }
    
    private final var elementComponentProvider: ElementComponentProvider?
    
    public final func setElementComponent(provider: @escaping ElementComponentProvider) { elementComponentProvider = provider }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        layoutComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfElementComponents }
        
        layoutComponent.setItemComponent { [unowned self] _, indexPath in
            
            switch self.elementComponent(at: indexPath.item) {
                
            case let .paragraph(component): return component
                
            case let .image(component): return component
                
            }
            
        }
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return layoutComponent.contentMode }
        
        set { layoutComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        layoutComponent.numberOfSections = (numberOfElementComponents == 0) ? 0 : 1
        
        layoutComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return layoutComponent.view }
    
    public final var preferredContentSize: CGSize { return layoutComponent.preferredContentSize }
    
}
