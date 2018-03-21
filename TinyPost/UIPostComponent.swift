//
//  UIPostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostComponent

public final class UIPostComponent: Component {
    
    /// The base component
    private final let listComponent: UIListComponent
    
    public private(set) final var elementComponents: [Component]
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.elementComponents = []
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        listComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in self.elementComponents.count }
            .setComponentForItem { self.elementComponents[$0.item] }
        
    }
    
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

public extension UIPostComponent {
    
    @discardableResult
    public final func setPost(
        elements: [PostElement]
    )
    -> UIPostComponent {
        
        let components: [Component] = elements.map { element in
            
            switch element {
                
            case let .text(text): return UIPostParagraphComponent().setText(text)
                
            case let .image(image): return UIPostImageComponent().setImage(image)
                
            }
            
        }
        
        // Insert spacings between elements.
        let defaultSpacing: CGFloat = 20.0
        
        let spacingComponent: (CGFloat) -> Component = { spacing in
            
            return UIItemComponent(
                contentMode: .size(
                    width: spacing,
                    height: spacing
                ),
                itemView: UIView()
            )
            
        }
        
        let spacedComponents = components.joined(
            separator: spacingComponent(defaultSpacing)
        )
        
        elementComponents = spacedComponents
        
        return self
            
    }
    
}
