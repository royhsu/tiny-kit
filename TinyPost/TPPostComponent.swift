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
        
        self.numberOfElements = 0
        
        self.prepare()
        
    }
    
    // MARK: PostComponent
    
    public final var numberOfElements: Int
    
    public final func element(at index: Int) -> Element {
        
        guard
            let element = elementProvider?(
                self,
                index
            )
        else { fatalError("Please make sure to set the element provider with function setElement(provider:) firstly.") }
        
        return element
        
    }
    
    private final var elementProvider: ElementProvider?
    
    public final func setElement(provider: @escaping ElementProvider) { elementProvider = provider }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        layoutComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfElements }
        
        layoutComponent.setItemComponent { [unowned self] _, indexPath in
            
            switch self.element(at: indexPath.item) {
                
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
        
        layoutComponent.numberOfSections = (numberOfElements == 0) ? 0 : 1
        
        layoutComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return layoutComponent.view }
    
    public final var preferredContentSize: CGSize { return layoutComponent.preferredContentSize }
    
}
