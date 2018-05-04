//
//  UIPostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostComponent

public final class UIPostComponent: PostComponent {
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
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
        
        listComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfElementComponents }
        
        listComponent.setItemComponent { [unowned self] _, indexPath in
            
            switch self.elementComponent(at: indexPath.item) {
                
            case let .paragraph(component): return component
                
            case let .image(component): return component
                
            }
            
        }
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        listComponent.numberOfSections = (numberOfElementComponents == 0) ? 0 : 1
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}
