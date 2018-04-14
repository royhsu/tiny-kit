//
//  TPPostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostComponent

public final class TPPostComponent: Component {

    /// The base component
    private final let listComponent: UIListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.numberOfElements = 0

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        listComponent.setItemComponent { [unowned self] indexPath in
            
            guard
                let element = self.elementProvider?(indexPath.item)
            else { fatalError("Please make sure to set up the element provider.") }
            
            switch element {
                
            case let .paragraph(text): return paragraphComponentFactory(text)
                
            case let .image(container):
                
                return imageComponentFactory(
                    self.view.bounds.width,
                    container
                )
                
            }
            
        }
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return listComponent.contentMode }

        set { listComponent.contentMode = newValue }

    }

    public final func render() {
        
        listComponent.numberOfSections = (numberOfElements == 0) ? 0 : 1
        
        listComponent.setNumberOfItemComponents { [unowned self] _ in self.numberOfElements }
        
        listComponent.render()
        
    }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
    // MARK: Element
    
    public final var numberOfElements: Int
    
    public typealias ElementProvider = (_ index: Int) -> TPPostElement
    
    private final var elementProvider: ElementProvider?
    
    public final func setElement(provider: @escaping ElementProvider) { elementProvider = provider }

}

public extension TPPostComponent {
    
    public final func setElements(
        _ elements: [TPPostElement]
    ) {
        
        numberOfElements = elements.count
        
        setElement { index in elements[index] }
        
    }
    
}

// MARK: - Factory

fileprivate let paragraphComponentFactory: (String) -> Component = { paragraph in
    
    let paragraphComponent = TPPostParagraphComponent()
    
    paragraphComponent.textLabel.text = paragraph
    
    paragraphComponent.applyTheme(.current)
    
    let boxComponent = UIBoxComponent(contentComponent: paragraphComponent)
    
    boxComponent.paddingInsets = UIEdgeInsets(
        top: 0.0,
        left: 16.0,
        bottom: 12.0,
        right: 16.0
    )
    
    return boxComponent
    
}

fileprivate let imageComponentFactory: (CGFloat, ImageContainer) -> Component = { imageWidth, imageContainer in
    
    let imageComponent = TPPostImageComponent(width: imageWidth)
    
    imageContainer.setImage(to: imageComponent.imageView)
    
    imageComponent.applyTheme(.current)
    
    let boxComponent = UIBoxComponent(contentComponent: imageComponent)
    
    boxComponent.paddingInsets = UIEdgeInsets(
        top: 0.0,
        left: 0.0,
        bottom: 12.0,
        right: 0.0
    )
    
    return boxComponent
    
}
